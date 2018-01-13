require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe "#secret_id" do
    it "is set for a new survey" do
      secret_id = Survey.new.secret_id
      expect(secret_id).to_not be_nil
      expect(secret_id).to be_an_instance_of String
    end

    it "is not overriden when loading a survey from the database" do
      competition = Competition.create! wca_competition_id: 1, name: "Example 2018",
                                        start_date: Date.today, end_date: Date.today,
                                        competitors_count: 100
      survey = Survey.create! competitor_email: "email@example.com", competition: competition
      expect(survey.secret_id).to eq survey.reload.secret_id
    end
  end
end
