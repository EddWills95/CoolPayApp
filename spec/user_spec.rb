require 'spec_helper'
require_relative '../lib/user'
require 'pry'

RSpec.describe User do
  let!(:user) { User.new(ENV['USERNAME'], ENV['API_KEY']) }
  
  it 'should create a new user object' do
    expect(user.username).to eq('EddW')
  end

  it 'should get a token for the user' do 
    mock_login
    expect(user.get_token).to eq('aff06fec-e041-4994-849e-223f0569e0bc')
  end
  
  it 'should have a logged in method' do
    mock_login
    user.get_token
    expect(user.logged_in?).to eq(true)
  end
end