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
end