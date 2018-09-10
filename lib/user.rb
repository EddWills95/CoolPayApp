require 'dotenv'
Dotenv.load
require 'net/http'
require 'json'

class User

  def initialize(username, key)
    @username = username
    @key = key
    @token = nil
  end

  def username
    @username
  end

  def get_token
    uri = URI(ENV['LOGIN_URL'])
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = {username: @username, apikey: @key}.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      @token = JSON.parse(http.request(req).read_body)['token']
    end
  end

  def logged_in?
    @token ? true : false
  end

end