require 'rest-client'
require_relative 'keys' if File.exist? './keys.rb'

module Auth
  def self.client_id
    ENV["CLIENT_ID"]
  end

  def self.client_secret
    ENV["CLIENT_KEY"]
  end

  def self.oauth_url(state)
    "https://github.com/login/oauth/authorize?" \
    "client_id=#{client_id}&" \
    "state=#{state}"
  end

  def self.obtain_token(code)   
    # Send auth request with code to obtain token
    payload = {
      :client_id => client_id,
      :client_secret => client_secret,
      :code => code
    }

    res = RestClient.post "https://github.com/login/oauth/access_token", payload, { :accept => "application/json" }

    if res.code != 200
      raise "Status code not 200"
    end

    token = JSON.parse(res)["access_token"]

    if token.nil?
      raise "Unable to obtain access token"
    end

    token
  end
end
