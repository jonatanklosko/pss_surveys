module WcaHelper
  def wca_url(path)
    ENV["WCA_ROOT_URL"] + path
  end

  def wca_authorization_url
    wca_url "/oauth/authorize?response_type=code&client_id=#{wca_client_id}&scope=public&redirect_uri=#{wca_callback_url}"
  end

  def wca_token_url
    wca_url "/oauth/token"
  end

  def wca_api_url(path)
    wca_url "/api/v0#{path}"
  end

  def wca_client_id
    ENV["WCA_CLIENT_ID"]
  end

  def wca_client_secret
    ENV["WCA_CLIENT_SECRET"]
  end
end
