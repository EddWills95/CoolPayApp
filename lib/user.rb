require 'dotenv'
Dotenv.load
require 'json'
require 'rest_client'
require_relative 'recipient'
require_relative 'payment'

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
  attr_reader :username

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
      }.to_json, { content_type: 'application/json' })
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
    incoming = JSON.parse(response.body)['recipients'].map { |json| Recipient.new(json) }
    @recipients = incoming
  end

  #
  # Search for a recipient
  #
  # @param [String] term Name of recipient that you are looking for
  #
  # @return [Recipient] Recipient Object
  #
  def search_recipients(term)
    response = @http.get(
      ENV['RECIPIENTS_URL'],
      Authorization: {
        content_type: 'application/json',
        authorization: "Bearer #{@token}"
      },
      params: {
        name: term
      }
    )
    JSON.parse(response.body)['recipients'].map { |json| Recipient.new(json) }
  end

  #
  # Add a recipient
  #
  # @param [String] name
  #
  # @return [Recipient] New Recipient Object
  #
  def add_recipient(name)
    response = @http.post(
      ENV['RECIPIENTS_URL'],
      {
        recipient: {
          name: "#{name}"
        }
      },
      { 
        authorization: "Bearer #{@token}",
        content_type: 'application/json' 
      }
    )

    Recipient.new(JSON.parse(response.body)['recipient'])
  end

  #
  # Create a payment
  #
  # @param [Recipient] payee
  # @param [Integer] amount
  #
  # @return [Payment] Payment Object
  #
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
      content_type: 'application/json',
      authorization: "Bearer #{@token}"
    )

    payment = Payment.new(JSON.parse(response.body)['payment'])
    @payments.push(payment)
    payment
  end

  #
  # Get all payments
  #
  # @return [Array<Payment>] Array of payment objects
  #
  def fetch_all_payments
    response = @http.get(
      ENV['PAYMENT_URL'],
      content_type: 'application/json',
      authorization: "Bearer #{@token}"
    )

    incoming = JSON.parse(response.body)['payments'].map { |json| Payment.new(json) }
    @payments = incoming
  end

  #
  # Return all payments in memory
  #
  # @return [Array<Payment>] Array of all payments that are currently in memory
  #
  attr_reader :payments

  #
  # Find a payment in current memory
  #
  # @param [String] id String ID of the payment you're looking for
  #
  # @return [Payment] Payment object that it finds
  #
  def lookup_payment(id)
    @payments.select { |p| p.id == id }.first
  end
end
