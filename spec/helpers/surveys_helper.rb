require 'rails_helper'

RSpec.describe SurveysHelper, type: :helper do
  describe "#submitted_surveys_stats" do
    let!(:competition) { create :competition }
    let!(:submitted_surveys) { create_list :survey, 5, :submitted, competition: competition }
    let!(:unsubmitted_surveys) { create_list :survey, 5, competition: competition }

    it "returns string including submitted surveys count as we as percentage" do
      expect(submitted_surveys_stats(competition.surveys)).to eq "5 (50%)"
    end
  end


  describe "#mean_rating_by_question" do
    let!(:competition) { create :competition }
    let!(:survey_questions) { create_list :survey_question, 2 }
    let!(:survey1) do
      create :survey, :submitted, competitor_competitions_count: 1, competition: competition, survey_answers_attributes: [
        { survey_question_id: survey_questions.first.id, rating: 9 },
        { survey_question_id: survey_questions.second.id, rating: 7 }
      ]
    end
    let!(:survey2) do
      create :survey, :submitted, competitor_competitions_count: 10, competition: competition, survey_answers_attributes: [
        { survey_question_id: survey_questions.first.id, rating: 8 },
        { survey_question_id: survey_questions.second.id, rating: 5 }
      ]
    end

    context "when weighted is set to false" do
      it "calculates arithmetic mean for each question" do
        expect(mean_rating_by_question(competition.surveys, weighted: false)).to eq ({
          survey_questions.first => (9 + 8) / 2.0,
          survey_questions.second => (7 + 5) / 2.0
        })
      end
    end

    context "when weighted is set to true" do
      it "calculates weighted mean usng survey weight" do
        weight1 = survey1.weight
        weight2 = survey2.weight
        expect(mean_rating_by_question(competition.surveys, weighted: true)).to eq ({
          survey_questions.first => (9 * weight1 + 8 * weight2) / (weight1 + weight2),
          survey_questions.second => (7 * weight1 + 5 * weight2) / (weight1 + weight2)
        })
      end
    end
  end

  describe "#mean" do
    it "computes arithmetic mean" do
      expect(mean([1, 2, 3])).to eq 2
    end

    it "doesn't round the result" do
      expect(mean([1, 2])).to eq 1.5
    end
  end
end
