class SurveysMailer < ApplicationMailer
  def send_survey(survey)
    @survey = survey
    mail(
      to: survey.competitor_email,
      subject: "Ankieta dot. #{survey.competition.name}"
    )
  end
end
