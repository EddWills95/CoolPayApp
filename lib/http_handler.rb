require 'net/http'
require 'pry'

class HttpHandler

  #
  # Simple Post Request>
  #
  # @param [String] url <URL to send request to
  # @param [Object] body Body as Object (Converted to JSON Automatically)
  # @param [Object] headers Required Headers as Object
  #
  # @return [String] Return the Body of the request
  #
  def post(url: nil, body: nil, headers: {'Content-Type': 'application/json'})
    return 'No URL Provided' unless url

    uri = URI(url)
    req = Net::HTTP::Post.new(uri, headers)
    req.body = body.to_json unless !body
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req).read_body
    end
  end

end