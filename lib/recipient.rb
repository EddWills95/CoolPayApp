# Put all the things into a module!

class Recipient

  def initialize(args)
    @id = args['id']
    @name = args['name']
  end

  def id
    @id
  end

  def name
    @name
  end

end