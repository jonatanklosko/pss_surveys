class SurveysController < ApplicationController
  def edit
    @survey = Survey.includes(:competition, :survey_answers).find_by! secret_id: params[:secret_id]
    return if redirect_to_root_if_surveys_closed
    # If there are not answers initialize them.
    if @survey.survey_answers.empty?
      @survey.survey_questions.each do |question|
        @survey.survey_answers.build survey_question_id: question.id
      end
    end
  end

  def update
    @survey = Survey.find_by! secret_id: params[:secret_id]
    return if redirect_to_root_if_surveys_closed
    @survey.submitted_at ||= DateTime.now
    if @survey.update survey_params
      redirect_to edit_survey_url(@survey), flash: {
        success: "Dziękujemy za wypełnienie ankiety. Możesz ją edytować aż do zakończenia procesu."
      }
    else
      flash.now[:danger] = "Błąd podczas wysyłania ankiety."
      render :edit
    end
  end

  def index
    @years = Competition.pluck(:start_date).map(&:year).uniq.sort.reverse
    @year = params[:year] || @years.max
    @competitions = Competition.surveys_closed
      .includes(surveys: { survey_answers: [:survey_question] })
      .where("date_part('year', start_date) = ?", @year)
  end

  private def survey_params
    params.require(:survey).permit(survey_answers_attributes: [:id, :rating, :comment, :survey_question_id])
  end

  private def redirect_to_root_if_surveys_closed
    if @survey.competition.surveys_closed?
      redirect_to root_url, flash: { warning: "Czas na wysyłanie ankiet minął." }
      return true
    end
  end
end
