class Survey < ApplicationRecord
  belongs_to :competition
  has_many :survey_answers, dependent: :destroy

  accepts_nested_attributes_for :survey_answers

  after_initialize :set_secret_id, if: :new_record?

  # Validate the number of answers if the survey is about to be saved as submitted.
  validate :must_have_all_answers, if: :submitted?

  private def must_have_all_answers
    if survey_answers.length != survey_questions.length
      errors.add :survey_answers, "wrong number of answers"
    end
  end

  def submitted?
    submitted_at.present?
  end

  def survey_questions
    SurveyQuestion.where(delegate: delegate?)
  end

  def to_param
    secret_id
  end

  def weight
    (Math.sqrt(competitor_competitions_count) + Math.cbrt(competitor_competitions_count)) / 2
  end

  private def set_secret_id
    self.secret_id = SecureRandom.uuid
  end
end
