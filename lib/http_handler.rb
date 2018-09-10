require 'net/http'
require 'pry'

class HttpHandler

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