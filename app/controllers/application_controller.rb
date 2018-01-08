class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private def redirect_to_root_unless_user(action, *args)
    (!current_user&.send(action, *args)).tap do |redirecting|
      if redirecting
        redirect_to root_url, flash: { danger: "Nie masz dostępu do tej strony." }
      end
    end
  end
end
