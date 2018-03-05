require "csv"

class CompetitionsController < ApplicationController
  include WcaHelper

  before_action -> { redirect_to_root_unless_user :admin? }, except: [:show, :index]
  before_action -> { redirect_to_root_unless_user :can_manage_competition?, Competition.find(params[:id]) }, only: [:show]

  def new
    recent_competitions_json = RestClient.get wca_api_url("/competitions"), params: {
      country_iso2: "PL",
      start: 1.month.ago.to_date,
      end: Date.today
    }
    existing_wca_competition_ids = Competition.pluck :wca_competition_id
    @competition_names_with_json = JSON.parse(recent_competitions_json)
      .reject { |competition_data| existing_wca_competition_ids.include? competition_data["id"] }
      .map { |competition_data| [competition_data["name"], competition_data.to_json] }
    if @competition_names_with_json.empty?
      redirect_to competitions_url, flash: { info: "Brak nowych zawodów." }
    end
  end

  def create
    competition_data = JSON.parse(params[:competition_wca_json]).deep_symbolize_keys!
    competition = Competition.initialize_from_wca_data competition_data
    if params[:registrations_csv_file].nil? || params[:results_xlsx_file].nil?
      return redirect_to new_competition_url, flash: { danger: "Nie wskazano potrzebnych plików." }
    end
    begin
      competitors = build_competitors params[:registrations_csv_file], params[:results_xlsx_file]
    rescue Exception => error
      redirect_to new_competition_url, flash: { danger: error } and return
    end
    # Build surveys.
    competition.competitors_count = competitors.count
    competitor_wca_ids = competitors.map { |competitor| competitor[:wca_id] }.compact
    competitions_count_by_wca_id = get_competitions_count_by_wca_id competitor_wca_ids
    competition_organizers = competition_data[:organizers].map { |organizer| organizer[:wca_id] }.compact
    competitors
      .select { |competitor| competitor[:country] == "Poland" && competitor[:email].present? }
      .reject { |competitor| competition_organizers.include? competitor[:wca_id] }
      .each do |competitor|
        competitions_count = competitions_count_by_wca_id[competitor[:wca_id]] || 0
        competitions_count += 1 # Count the competition that we are currently dealing with assuming results are not posted yet.
        competition.surveys.build competitor_email: competitor[:email], competitor_competitions_count: competitions_count
      end
    competition_data[:delegates].each do |delegate|
      competitions_count = competitions_count_by_wca_id[delegate[:wca_id]]
      competition.surveys.build competitor_email: delegate[:email], delegate: true, competitor_competitions_count: competitions_count
    end
    competition_data[:organizers].each do |organizer|
      competition.organizers << User.find_or_initialize_from_wca_data(organizer)
    end
    if competition.save
      competition.surveys.each { |survey| SurveysMailer.send_survey(survey).deliver_later }
      redirect_to competitions_url, flash: { success: "Ankiety zostały wysłane." }
    else
      redirect_to new_competition_url, flash: { danger: "Operacja nie powiodła się." }
    end
  end

  def index
    @competitions = Competition.all.order end_date: "desc"
  end

  def show
    @competition = Competition.includes(surveys: { survey_answers: [:survey_question] }).find params[:id]
    @delegate_surveys, @competitor_surveys = @competition.surveys.partition &:delegate?
  end

  def close_surveys
    competition = Competition.includes(:surveys).find params[:id]
    if competition.cannot_close_surveys_reasons.empty?
      competition.touch :surveys_closed_at
      redirect_to competition_url(competition), flash: { success: "Zamknięto ankiety." }
    else
      redirect_to competition_url(competition), flash: { danger: "Nie można zamknąć ankiet." }
    end
  end

  private def build_competitors(registrations_csv_file, results_xlsx_file)
    # Ensure the CSV file includes all required columns.
    headers = CSV.read(registrations_csv_file.path).first.map(&:downcase)
    ["name", "email", "birth date"].each do |required_header|
      raise "Brak kolumny '#{required_header}' w pliku #{registrations_csv_file.original_filename}" unless headers.include?(required_header)
    end
    # Read all registrations (from a registration system).
    registrations = CSV.read(registrations_csv_file.path, headers: true, header_converters: :symbol, skip_blanks: true, converters: ->(string) { string.strip })
      .map(&:to_hash)
      .reject { |competitor| competitor.values.all? &:nil? }
    # Read competitors from competition results (people that have actually participated).
    # The template can be found here: https://www.worldcubeassociation.org/files/results.xls
    workbook = Roo::Spreadsheet.open results_xlsx_file.path
    competitors_sheet = workbook.sheet("Registration")
    competitors = competitors_sheet.drop(3).take_while(&:second).map do |row|
      { name: row[1].gsub(/\s+\(.+\)/, ''), country: row[2], wca_id: row[3], gender: row[4], birth_date: row[5].to_s }
    end
    # Extend competitors with emails from registrations data.
    competitors.each do |competitor|
      # Assume (name, birth date) to be a unique identifier.
      registration = registrations.find do |registration|
        registration[:name] == competitor[:name] && registration[:birth_date] == competitor[:birth_date]
      end
      if registration.nil?
        raise "Nie znaleziono zawodnika #{competitor[:name]} w pliku #{registrations_csv_file.original_filename}"
      elsif competitor[:country].blank?
        raise "Brak kraju dla zawodnika #{competitor[:name]}."
      end
      competitor[:email] = registration[:email]
    end
  end
end
