class SurveyAnswer < ApplicationRecord
  belongs_to :survey
  belongs_to :survey_question

  validates :rating, inclusion: 1..10
end
