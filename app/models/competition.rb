class Competition < ApplicationRecord
  has_many :surveys, dependent: :destroy

  def self.initialize_from_wca_data(competition_json_data)
    competition_json_data.deep_symbolize_keys!
    Competition.new.tap do |competition|
      competition.wca_competition_id = competition_json_data[:id]
      competition.name = competition_json_data[:name]
      competition.start_date = Date.parse(competition_json_data[:start_date])
      competition.end_date = Date.parse(competition_json_data[:end_date])
    end
  end

  def cannot_close_surveys_reasons
    [].tap do |reasons|
      delegate_surveys, competitor_surveys = surveys.partition &:delegate?
      unless delegate_surveys.any? &:submitted?
        reasons << "Wymagana jest co najmniej jedna ankieta delegacka."
      end
      if competitor_surveys.count(&:submitted?).to_f / competitor_surveys.count < 0.2
        reasons << "Wymagane jest co conajmniej 20% nadesłanych ankiet zawodniczych."
      end
    end
  end

  def surveys_closed?
    surveys_closed_at.present?
  end
end
