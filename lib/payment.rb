#
# Payment class wrapper
#
class Payment
  def initialize(args)
    @id = args['id']
    @amount = args['amount'].to_i
    @currency = args['currency']
    @recipient_id = args['recipient_id']
    @status = args['status']
  end

  attr_reader :id

  attr_reader :amount

  attr_reader :currency

  attr_reader :recipient_id

  attr_reader :status
end
