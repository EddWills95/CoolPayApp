require 'spec_helper'
require 'http_handler'

RSpec.describe HttpHandler do

  let!(:http) { HttpHandler.new }

  it 'should return an error if no url' do
    expect(http.post).to eq('No URL Provided')
  end

  it 'should post with body and return response' do
    mock_simple_post
    expect(http.post(
      url: 'http://test.com',
      body: 'hello'
    )).to eq('Success')
  end

end