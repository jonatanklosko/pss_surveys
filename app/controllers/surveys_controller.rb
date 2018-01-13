class SurveysController < ApplicationController
  def edit
    @survey = Survey.includes(:competition, :survey_answers).find_by! secret_id: params[:secret_id]
    # If there are not answers initialize them.
    if @survey.survey_answers.empty?
      @survey.survey_questions.each do |question|
        @survey.survey_answers.build survey_question_id: question.id
      end
    end
  end

  def update
    @survey = Survey.find_by! secret_id: params[:secret_id]
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

  private def survey_params
    params.require(:survey).permit(survey_answers_attributes: [:id, :rating, :comment, :survey_question_id])
  end
end
