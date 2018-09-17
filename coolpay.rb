Dir["./lib/*.rb"].each {|file| require_relative file }

require_relative './lib/user'

require 'fancy_gets'
include FancyGets

require 'pry'

class Coolpay
  attr_accessor :level  
  @level = 0
  @user = nil

  def self.user=(user)
    @user = user
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
      self.recipients
    when 'Exit'
      return nil
    end
  end

  def self.recipients
    selection = gets_list(levels[2])
    case selection
    when 'List'
      recipients = @user.fetch_all_recipients
      if recipients.length > 0
        self.display_recipients(recipients)
        sleep(1)
        self.recipients
      else
        puts 'none to show'
        sleep(1)
        self.recipients
      end
    when 'Add'
      puts "Input a name"
      name = gets
      
      new_recip = @user.add_recipient(name)
      puts "#{new_recip.name} added!"
      sleep(1)
      self.recipients 
    when 'Back'
      self.authenticated
      return 'Exit'
    end
  end

  def self.display_recipients(recipients)
    puts recipients.map(&:name)
  end

  private
  def self.levels 
    puts `clear`
    levels = [
      ['Authenticate', 'Exit'],
      ['Recipients', 'Payments', 'Exit'],
      ['List', 'Add', 'Remove', 'Back']
    ] 
  end
end


selection = Coolpay.start

while true
  case selection
  when 'Authenticate'
    Coolpay.clear
    puts 'Authenticating you'
    user = User.new(ENV['USERNAME'], ENV['API_KEY'])
    user.get_token

    if user.logged_in?
      Coolpay.user = user
      Coolpay.clear
      selection = Coolpay.authenticated
    end
  when 'Exit'
    break;
  end
  Coolpay.clear
  puts 'Thanks for playing'
  break;
end