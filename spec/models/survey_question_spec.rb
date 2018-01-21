require 'rails_helper'

RSpec.describe SurveyQuestion, type: :model do
  it "has a valid factory" do
    expect(build(:survey_question)).to be_valid
  end
end
