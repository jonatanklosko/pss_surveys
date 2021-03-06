module WcaHelper
  def wca_url(path)
    wca_root_url + path
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

  def get_competitions_count_by_wca_id(all_wca_ids)
    all_wca_ids.each_slice(100).flat_map do |wca_ids|
      people_json = RestClient.get wca_api_url("/persons"), params: {
        per_page: 100,
        wca_ids: wca_ids.join(",")
      }
      JSON.parse people_json
    end
    .map! { |person_data| [person_data["person"]["wca_id"], person_data["competition_count"]] }
    .to_h
  end

  def wca_root_url
    ENV["WCA_ROOT_URL"]
  end

  def wca_client_id
    ENV["WCA_CLIENT_ID"]
  end

  def wca_client_secret
    ENV["WCA_CLIENT_SECRET"]
  end

  def wca_competition_link(competition)
    link_to competition.name, wca_url("/competitions/#{competition.wca_competition_id}"), target: "_blank"
  end
end
