require 'rails_helper'

RSpec.describe "Surveys", type: :request do
  describe "submission" do
    context "when surveys are open" do
      let!(:survey) { create :survey }
      let!(:survey_questions) { create_list :survey_question, 2 }

      it "renders successful message if all answers are present" do
        get edit_survey_path(survey)
        expect {
          patch survey_path(survey), params: {
            survey: {
              survey_answers_attributes: {
                "0" => { survey_question_id: survey_questions.first.id, rating: 6, comment: "" },
                "1" => { survey_question_id: survey_questions.second.id, rating: 8, comment: "Really great." }
              }
            }
          }
          survey.reload
        }.to change { survey.submitted_at }
         .and change { survey.survey_answers.count }.from(0).to(2)
        expect(response).to redirect_to edit_survey_url(survey)
        follow_redirect!
        expect(response.body).to include "Dziękujemy za wypełnienie ankiety."
      end

      it "fails if some answers are missing" do
        get edit_survey_path(survey)
        expect {
          patch survey_path(survey), params: {
            survey: {
              survey_answers_attributes: {
                "0" => { survey_question_id: survey_questions.first.id, rating: 6, comment: "" }
              }
            }
          }
          survey.reload
        }.to_not change { survey.submitted_at }
        expect(survey.survey_answers.count).to eq 0
        expect(response.body).to include "Błąd podczas wysyłania ankiety."
      end
    end

    context "when surveys are closed" do
      let!(:survey) { create :survey, competition: create(:competition, :surveys_closed) }

      it "redirects with message" do
        get edit_survey_path(survey)
        expect(response).to redirect_to root_url
        follow_redirect!
        expect(response.body).to include "Czas na wysyłanie ankiet minął."
      end
    end

    context "when a survey has already been submitted" do
      let!(:survey) { create :survey, :submitted }
      let!(:first_answer) { create :survey_answer, survey: survey, rating: 5, comment: "Quite bad." }
      let!(:second_answer) { create :survey_answer, survey: survey }

      it "allows updating" do
        expect {
          patch survey_path(survey), params: {
            survey: {
              survey_answers_attributes: {
                "0" => { id: first_answer.id, rating: 7, comment: "It wasn't that bad." }
              }
            }
          }
          first_answer.reload
        }.to change { first_answer.rating }.from(5).to(7)
         .and change { first_answer.comment }.from("Quite bad.").to("It wasn't that bad.")
      end
    end
  end
end
