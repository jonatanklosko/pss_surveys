require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:survey) { create :survey }

  describe "#secret_id" do
    it "is set for a new survey" do
      secret_id = Survey.new.secret_id
      expect(secret_id).to_not be_nil
      expect(secret_id).to be_an_instance_of String
    end

    it "is not overriden when loading a survey from the database" do
      expect(survey.secret_id).to eq survey.reload.secret_id
    end
  end

  describe "#survey_answers" do
    let!(:competitor_questions) { create_list :survey_question, 2 }
    let!(:delegate_question) { create :survey_question, delegate: true }

    context "when submitted_at is set" do
      it "must be present for all questions of corresponding type" do
        survey.submitted_at = DateTime.now
        survey.survey_answers = [build(:survey_answer, survey_question: competitor_questions.first)]
        expect(survey).to be_invalid
        expect(survey.errors.messages[:survey_answers]).to eq ["wrong number of answers"]
        survey.survey_answers << build(:survey_answer, survey_question: competitor_questions.second)
        expect(survey).to be_valid
      end
    end
  end
end
