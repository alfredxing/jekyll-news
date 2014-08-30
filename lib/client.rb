require 'rest-client'
require 'json'

class Client
	attr_accessor :token, :user

  API_URL = "https://api.github.com/"
  USER_KEYS = ["name", "login", "id", "avatar_url"]

  def initialize(token)
    @token = token
    @user = get("user").select { |key| USER_KEYS.include? key.to_s }
  end

  def get(url)
    JSON.parse(RestClient.get(API_URL + url + "?access_token=#{@token}"){ |s, q, t| s.to_s }, :symbolize_names => true)
  end

  def post(url, payload)
    JSON.parse(RestClient.post(API_URL + url + "?access_token=#{@token}", payload.to_json){ |s, q, t| s.to_s }, :symbolize_names => true)
  end

  def patch(url, payload)
    JSON.parse(RestClient.patch(API_URL + url + "?access_token=#{@token}", payload.to_json){ |s, q, t| s.to_s }, :symbolize_names => true)
  end

  # API methods

  def email
    @email ||= get("user/emails").detect { |email| email[:primary] }[:email]
  end
end
