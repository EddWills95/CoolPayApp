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

  describe 'recipients' do
    before do
      mock_login
      mock_recipients
      mock_search_recipients
      mock_add_recipient
      user.get_token
    end

    it 'should be return an array of recpient objects' do
      expect(user.fetch_all_recipients.first.name).to eq('Interesting Person')
    end

    it 'should return searched recipients' do
      expect(user.search_recipients('joe').first.name).to eq('Joe Bloggs')
    end

    it 'should be able to add recipients' do
      expect(user.add_recipient('Jeffery Archer').id).to eq('e9a0336b-d81d-4009-9ad1-8fa1eb43418c')
    end
  end

  describe 'payments' do
    
    before do
      mock_login
      mock_recipients
      mock_create_payment
      user.get_token
    end

    let(:recipient) { Recipient.new(id: '11111', name: 'Mr McNeedy')}

    it 'should be able to create a payment' do
      expect(user.create_payment(recipient, 20).amount).to eq(20)
    end

    it 'should be able to show all payments' do
      expect(user.payments).to eq([])
    end
  
  end

end

