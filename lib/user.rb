require 'dotenv'
Dotenv.load
require 'json'
require 'rest_client'

class User
  #
  # Initialzer
  #
  # @param [String] username
  # @param [String] key
  #
  def initialize(username, key)
    @http = RestClient
    @username = username
    @key = key
    @token = nil
  end

  #
  # Return the username from user Object
  #
  # @return [Boolean]
  #
  def username
    @username
  end

  #
  # Fetch Token from API
  #
  # @return [String] Will save token to class and return token string
  #
  def get_token
    response = @http.post(
      ENV['LOGIN_URL'],
      {
        username: @username,
        apikey: @key
      }.to_json
    )
    @token = JSON.parse(response.body)['token']
  end

  #
  # Return logged in status
  #
  # @return [Boolean] Logged In Status
  #
  def logged_in?
    @token ? true : false
  end

end