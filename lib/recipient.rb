#
# Class wrapper for a recipient
#
class Recipient
  def initialize(args)
    @id = args['id']
    @name = args['name']
  end

  attr_reader :id

  attr_reader :name
end
