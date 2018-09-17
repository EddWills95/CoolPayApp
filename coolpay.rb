Dir["./lib/*.rb"].each {|file| require_relative file }

require_relative './lib/user'

require 'fancy_gets'
include FancyGets

require 'pry'

class Coolpay
  attr_accessor :level
  @level = 0

  def self.start
    gets_list(levels[@level])
  end

  def self.clear
    puts `clear`
  end

  def self.next_level
    @level += 1
  end

  private
  def self.levels 
    levels = [
      ['Authenticate', 'Recipients', 'Payments', 'Exit'],
      ['Recipients', 'Payments', 'Exit']
    ] 
  end
end


while true
  selection = Coolpay.start


  case selection
  when 'Authenticate'
    Coolpay.clear
    puts 'Authenticating you'
    user = User.new(ENV['USERNAME'], ENV['API_KEY'])
    if user
      Coolpay.clear
      puts "Hello #{user.username}"
      Coolpay.next_level
    end
  when 'Exit'
    Coolpay.clear
    puts 'Thanks for playing'
    break;
  end
end