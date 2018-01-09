class ApplicationMailer < ActionMailer::Base
  include ActionMailer::Text

  default from: "ankiety@kostkarubika.org"
  layout "mailer"
end
