require 'rails_helper'

RSpec.describe Competition, type: :model do
  it "has a valid factory" do
    expect(build(:competition)).to be_valid
  end

  describe ".initialize_from_wca_data" do
    let(:competition_data) {{
      id: "Example2018",
      name: "Great Example 2018",
      start_date: "2018-01-01",
      end_date: "2018-01-02",
    }}

    it "initializes a competition from parsed json data" do
      competition = Competition.initialize_from_wca_data(competition_data)
      expect(competition.wca_competition_id).to eq competition_data[:id]
      expect(competition.name).to eq competition_data[:name]
      expect(competition.start_date).to be_an_instance_of Date
      expect(competition.start_date.to_s).to eq competition_data[:start_date]
      expect(competition.end_date).to be_an_instance_of Date
      expect(competition.end_date.to_s).to eq competition_data[:end_date]
    end
  end
end
