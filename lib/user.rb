require 'dotenv'
Dotenv.load
require 'json'
require 'rest_client'
require 'recipient'
require 'payment'

class User
  #
  # Initialzer
  #
  # @param [String] username
  # @param [String] key
  #
  def initialize(username, key)
    @http = RestClient
    @username = username
    @key = key
    @token = nil
    @recipients = nil
    @payments = []
  end

  #
  # Return the username from user Object
  #
  # @return [Boolean]
  #
  def username
    @username
  end

  #
  # Fetch Token from API
  #
  # @return [String] Will save token to class and return token string
  #
  def get_token
    response = @http.post(
      ENV['LOGIN_URL'],
      {
        username: @username,
        apikey: @key
      }.to_json
    )
    @token = JSON.parse(response.body)['token']
  end

  #
  # Return logged in status
  #
  # @return [Boolean] Logged In Status
  #
  def logged_in?
    @token ? true : false
  end  
  
  # This is a good idea to avoid always having to make the call to the API

  # def recpients
  #   return @recipients unless !@recipients
  #   return 'Must fetch first'
  # end

  def fetch_all_recipients
    response = @http.get(
      ENV['RECIPIENTS_URL'],
      {
        content_type: 'application/json',
        authorization: "Bearer #{@token}"
      }
    )
    JSON.parse(response.body)['recipients'].map { |json| Recipient.new(json) }
  end

  def search_recipients(term)
    response = @http.get(
      ENV['RECIPIENTS_URL'],
      {
        Authorization: {
          content_type: 'application/json',
          authorization: "Bearer #{@token}"
        },
        params: {
          name: term
        }
      }
    )
    JSON.parse(response.body)['recipients'].map { |json| Recipient.new(json) }
  end

  def add_recipient(name)
    body = `{
      "recipient": {
        "name": "#{name}"
      }
    `

    response = @http.post(
      ENV['RECIPIENTS_URL'],
      body,
      {
        content_type: 'application/json',
        authorization: "Bearer #{@token}"
      }
    )

    Recipient.new(JSON.parse(response.body)['recipient'])
  end

  def create_payment(payee, amount)

    body = `{
      "payment": {
        "amount": #{amount},
        "currency": "GBP"
        recipient_id: #{payee.id}
      }
    }`

    response = @http.post(
      ENV['PAYMENT_URL'],
      body,
      {
        content_type: 'application/json',
        authorization: "Bearer #{@token}"
      }
    )
    
    payment = Payment.new(JSON.parse(response.body)['payment'])
    @payments.push(payment)
    payment
  end

  def payments
    @payments
  end

end
