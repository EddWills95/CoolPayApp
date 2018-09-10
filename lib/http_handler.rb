require 'net/http'
require 'pry'

class HttpHandler

  # Response Object Struct with Body and Status Code
  ResponseObject = Struct.new(:body, :status)

  #
  # <Simple Get Request>
  #
  # @param [String] url URL to send request to
  # @param [Object] body Body as Object (Converted to JSON Automatically)
  # @param [Object] headers Required Headers as Object
  #
  # @return [ResponseObject]
  #
  def get(url: nil, headers: {}, params: {})
    return 'No URL Provided' unless url
      
    uri = URI(url)
    req = Net::HTTP.Get.new(url, headers)
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    ResponseObject.new(res.read_body, res.code)
  end

  #
  # Simple Post Request>
  #
  # @param [String] url URL to send request to
  # @param [Object] body Body as Object (Converted to JSON Automatically)
  # @param [Object] headers Required Headers as Object
  #
  # @return [ResponseObject] Return the Body of the request
  #
  def post(url: nil, body: nil, headers: {'Content-Type': 'application/json'})
    return 'No URL Provided' unless url

    uri = URI(url)
    req = Net::HTTP::Post.new(uri, headers)
    req.body = body.to_json unless !body
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    ResponseObject.new(res.read_body, res.code)
  end

end