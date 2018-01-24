class ApplicationMailer < ActionMailer::Base
  include ActionMailer::Text

  default from: ENV["MAIL_FROM"]
  layout "mailer"
end
