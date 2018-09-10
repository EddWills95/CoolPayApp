require 'spec_helper'
require 'http_handler'

RSpec.describe HttpHandler do

  let!(:http) { HttpHandler.new }

  it 'should return an error if no url for all requests' do
    expect(http.get).to eq('No URL Provided')
    expect(http.post).to eq('No URL Provided')
  end

  it 'should post with body and return response' do
    mock_simple_post
    response = http.post(
      url: 'http://test.com',
      body: 'hello'
    )

    expect(response.body).to eq('Success')
    expect(response.status).to eq('200')
  end

end