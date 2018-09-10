require 'dotenv'
Dotenv.load
require 'net/http'
require 'json'

class User

  #
  # <Initialzer>
  #
  # @param [<String>] username
  # @param [<String>] key
  #
  def initialize(username, key)
    @username = username
    @key = key
    @token = nil
  end

  #
  # <Return the username from user Object>
  #
  # @return [<Boolean>]
  #
  def username
    @username
  end

  #
  # <Fetch Token from API>
  #
  # @return [<String>] <Will save token to class and return token string>
  #
  def get_token
    uri = URI(ENV['LOGIN_URL'])
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = {username: @username, apikey: @key}.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      @token = JSON.parse(http.request(req).read_body)['token']
    end
  end

  #
  # <Return logged in status>
  #
  # @return [<Boolean>] <Logged In Status>
  #
  def logged_in?
    @token ? true : false
  end

end