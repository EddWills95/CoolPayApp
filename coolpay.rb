Dir['./lib/*.rb'].each { |file| require_relative file }

require_relative './lib/user'

require 'fancy_gets'
include FancyGets

require 'pry'

class Coolpay
  attr_accessor :level
  @level = 0
  @user = nil

  class << self
    attr_writer :user
  end

  def self.start
    gets_list(levels[@level])
  end

  def self.clear
    puts `clear`
  end

  def self.next_level
    @level += 1
  end

  def self.authenticated
    selection = gets_list(levels[1])
    puts "Hello #{@user.username}"
    case selection
    when 'Recipients'
      recipients
    when 'Payments'
      payments
    when 'Exit'
      return nil
    end
  end

  def self.recipients
    selection = gets_list(levels[2])
    case selection
    when 'List'
      recipients = @user.fetch_all_recipients
      if !recipients.empty?
        display_recipients(recipients)
        sleep(1)
        self.recipients
      else
        puts 'none to show'
        sleep(1)
        self.recipients
      end
    when 'Add'
      puts 'Input a name'
      name = gets

      new_recip = @user.add_recipient(name)
      puts "#{new_recip.name} added!"
      sleep(1)
      self.recipients
    when 'Back'
      authenticated
      return 'Exit'
    end
  end

  def self.display_recipients(recipients)
    puts recipients.map(&:name) + `\n`
  end

  def self.display_payments(payments)
    # puts payments.map(&:amount) + `\n`
    payments.each do |p|
      puts "#{p.amount}#{p.currency}"
      sleep(2)
    end
  end

  def self.payments
    selection = gets_list(levels[3])
    case selection
    when 'List'
      payments = @user.fetch_all_payments
      unless payments.empty?
        display_payments(payments)
        sleep(1)
        self.payments
      end
      self.payments
      # else
      #   puts 'None to display'
      #   sleep(1)
      #   self.payments
      # end
    when 'New'
      recipients = @user.fetch_all_recipients
      payee = gets_list(recipients.map(&:name))
      payee_obj = recipients.select { |r| r.name == payee }.first
      puts `clear`
      puts 'Amount: '
      amount = gets.chomp
      payment = @user.create_payment(payee_obj, amount)
      puts payment.amount
      sleep(2)
      self.payments
    when 'Back'
      authenticated
      return 'Exit'
    end
  end

  private

  def self.levels
    puts `clear`
    levels = [
      %w[Authenticate Exit],
      %w[Recipients Payments Exit],
      %w[List Add Back],
      %w[List New Back]
    ]
  end
end

selection = Coolpay.start

loop do
  case selection
  when 'Authenticate'
    Coolpay.clear
    puts 'Authenticating you'
    user = User.new(ENV['USERNAME'], ENV['API_KEY'])
    user.get_token

    if user.logged_in?
      Coolpay.user = user
      Coolpay.clear
      Coolpay.authenticated
    end
  when 'Exit'
    break
  end
  Coolpay.clear
  puts 'Thanks for playing'
  break
end
