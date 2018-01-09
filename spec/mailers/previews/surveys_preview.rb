# Preview all emails at http://localhost:3000/rails/mailers/surveys
class SurveysPreview < ActionMailer::Preview
  def send_survey
    SurveysMailer.send_survey Survey.first
  end
end
