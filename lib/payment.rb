class Payment

  def initialize(args)
    @id = args['id']
    @amount = args['amount'].to_i
    @currency = args['currency']
    @recipient_id = args['recipient_id']
    @status = args['status']
  end

  def id
    @id
  end

  def amount
    @amount
  end

  def currency
    @currency
  end

  def recipient_id
    @recipient_id
  end

  def status
    @status
  end
end