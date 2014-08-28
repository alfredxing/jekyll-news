require 'rest-client'

module Auth
  def self.oauth_url(state)
    "https://github.com/login/oauth/authorize?" \
    "client_id=40c9f8fbca82090d3af9&" \
    "scope=user:email&" \
    "state=#{state}"
  end

  def self.obtain_token(code)   
    # Send auth request with code to obtain token
    payload = {
      :client_id => "40c9f8fbca82090d3af9",
      :client_secret => "3b9346850fc50b2a7e3d9ee2db71b4e37f7caf25",
      :code => code
    }

    res = RestClient.post "https://github.com/login/oauth/access_token", payload, { :accept => "application/json" }

    if res.code != 200
      raise "Status code not 200"
    end

    token = JSON.parse(res)["access_token"]

    if token.nil?
      raise "Token not part of response"
    end

    token
  end
end
