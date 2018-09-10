module Helpers
  def mock_login
    stub_request(:post, "http://coolpay.herokuapp.com:443/api/login")
    .with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type'=>'application/json',
      'Host'=>'coolpay.herokuapp.com',
      'User-Agent'=>'Ruby'
      }
    )
    .to_return(body:
      { token: "aff06fec-e041-4994-849e-223f0569e0bc" }.to_json, 
      status: 200
    )
  end
end