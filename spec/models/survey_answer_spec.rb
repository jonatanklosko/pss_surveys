require 'rails_helper'

RSpec.describe SurveyAnswer, type: :model do
  it "has a valid factory" do
    expect(build(:survey_answer)).to be_valid
  end

  describe "#rating" do
    it "must be between 1 and 10" do
      expect(build(:survey_answer, rating: 0)).to be_invalid
      expect(build(:survey_answer, rating: 11)).to be_invalid
      expect(build(:survey_answer, rating: 7)).to be_valid
    end

    it "must be a natural number" do
      expect(build(:survey_answer, rating: 5.5)).to be_invalid
    end
  end
end
