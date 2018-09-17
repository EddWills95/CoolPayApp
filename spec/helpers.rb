module Helpers
  def mock_simple_post
    stub_request(:post, "http://test.com")
      .to_return(
        body: 'Success',
        status: 200
      )
  end

  def mock_login
    stub_request(:post, "https://coolpay.herokuapp.com/api/login").
    with(
      body: "{\"username\":\"EddW\",\"apikey\":\"2C96F8324E3BA54A\"}",
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip, deflate',
      'Content-Length'=>'47',
      'Host'=>'coolpay.herokuapp.com',
      'User-Agent'=>'rest-client/2.0.2 (darwin18.0.0 x86_64) ruby/2.5.1p57'
      })
    .to_return(body:
      { token: "aff06fec-e041-4994-849e-223f0569e0bc" }.to_json, 
      status: 200
    )
  end

  def mock_recipients
    stub_request(:get, "https://coolapy.herokuapp.com/api/recipients").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip, deflate',
      'Authorization'=>'Bearer aff06fec-e041-4994-849e-223f0569e0bc',
      'Content-Type'=>'application/json',
      'Host'=>'coolapy.herokuapp.com',
      'User-Agent'=>'rest-client/2.0.2 (darwin18.0.0 x86_64) ruby/2.5.1p57'
      }).
    to_return(
      status: 200, body: {
      recipients: [
        {
          id: "6e7b4cea-5957-11e6-8b77-86f30ca893d3",
          name: "Interesting Person"
        }
      ]
    }.to_json, headers: {})
  end

  def mock_search_recipients
    stub_request(:get, "https://coolapy.herokuapp.com/api/recipients?name=joe").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip, deflate',
      'Authorization'=>'{:content_type=>"application/json", :authorization=>"Bearer aff06fec-e041-4994-849e-223f0569e0bc"}',
      'Host'=>'coolapy.herokuapp.com',
      'User-Agent'=>'rest-client/2.0.2 (darwin18.0.0 x86_64) ruby/2.5.1p57'
      }).
    to_return(status: 200, body: {
      recipients: [
        {
          id: "6e7b4cea-5957-11e6-8b77-86f30ca893d3",
          name: "Joe Bloggs"
        }
      ]
    }.to_json, headers: {})
  end
end