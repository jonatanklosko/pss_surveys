class SessionsController < ApplicationController
  include WcaHelper

  def new
    redirect_to wca_authorization_url
  end

  def create
    token_response = RestClient.post wca_token_url, {
      code: params[:code],
      grant_type: "authorization_code",
      redirect_uri: wca_callback_url,
      client_id: wca_client_id,
      client_secret: wca_client_secret
    }
    access_token = JSON.parse(token_response.body)["access_token"]
    me_response = RestClient.get wca_api_url("/me"), { authorization: "Bearer #{access_token}" }
    user_data = JSON.parse(me_response.body)["me"]
    user = User.find_or_initialize_from_wca_data(user_data)
    if user.save
      sign_in user
      redirect_to root_url, flash: { success: "Witaj #{user.name}!" }
    else
      redirect_to_root_with_error
    end
  rescue RestClient::ExceptionWithResponse => error
    redirect_to_root_with_error
  end

  def destroy
    sign_out current_user if current_user
    redirect_to root_url
  end

  private def redirect_to_root_with_error
    redirect_to root_url, flash: { danger: "Wystąpił błąd podczas próby logowania." }
  end
end
