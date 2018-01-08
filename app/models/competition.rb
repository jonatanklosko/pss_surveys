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
end
