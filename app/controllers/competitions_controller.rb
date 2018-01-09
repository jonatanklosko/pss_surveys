require "csv"

class CompetitionsController < ApplicationController
  include WcaHelper

  before_action -> { redirect_to_root_unless_user :admin? }

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
  end

  def create
    competition_data = JSON.parse(params[:competition_wca_json]).deep_symbolize_keys!
    competition = Competition.initialize_from_wca_data competition_data
    if params[:competitors_csv_file].nil?
      return redirect_to new_competition_url, flash: { danger: "Nie wskazano pliku z listą zawodników." }
    end
    competitors = CSV.read(params[:competitors_csv_file].path, headers: true, header_converters: :symbol, skip_blanks: true)
      .map(&:to_hash)
      .reject { |competitor| competitor.values.all? &:nil? }
    competition.competitors_count = competitors.count
    competitor_wca_ids = competitors.map { |competitor| competitor[:wca_id] }.compact
    competitions_count_by_wca_id = get_competitions_count_by_wca_id competitor_wca_ids
    delegate_wca_ids = competition_data[:delegates].map { |delegate| delegate[:wca_id] }
    competitors.each do |competitor|
      if competitor[:country].blank? || competitor[:email].blank?
        return redirect_to new_competition_url, flash: { danger: "Brak wymaganych danych dla zawodnika #{competitor[:name]}." }
      elsif competitor[:country] == "Poland" && !delegate_wca_ids.include?(competitor[:wca_id])
        competitions_count = competitions_count_by_wca_id[competitor[:wca_id]] || 0
        competitions_count += 1 # Count the competition that we are currently dealing with assuming results are not posted yet.
        competition.surveys.build competitor_email: competitor[:email], competitor_competitions_count: competitions_count
      end
    end
    competition_data[:delegates].each do |delegate|
      competitions_count = competitions_count_by_wca_id[delegate[:wca_id]]
      competition.surveys.build competitor_email: delegate[:email], delegate: true, competitor_competitions_count: competitions_count
    end
    if competition.save
      competition.surveys.each { |survey| SurveysMailer.send_survey(survey).deliver_now }
      redirect_to competitions_url, flash: { success: "Ankiety zostały wysłane." }
    else
      redirect_to new_competition_url, flash: { danger: "Operacja nie powiodła się." }
    end
  end

  def index
    @competitions = Competition.all.order end_date: "desc"
  end

  def show
  end
end
