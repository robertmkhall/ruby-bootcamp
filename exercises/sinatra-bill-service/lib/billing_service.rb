require 'json'

class BillingAccountNotFound < Exception
end

class BillNotFound < Exception
end

class BillingService

  ROOT = Pathname.new(File.expand_path(__dir__))
  BILL_PATH = ROOT.join("../resources").join('bill.json').to_s

  # Hardcoded constants (obviously not like this in real world)
  BILL_IDS = ['10000001', '10000002']

  attr_reader :bill_path

  def initialize(bill_path = BILL_PATH)
    puts "bill path = #{bill_path}"
    @bill_path = bill_path
  end

  def bill(bill_id)
    raise BillNotFound unless bill_exists? bill_id

    File.read(bill_path)
  end

  def bill_ids(username)
    raise BillingAccountNotFound unless username_exists? username

    JSON.generate({ids: BILL_IDS})
  end

  def bill_exists?(bill_id)
    BILL_IDS.include? bill_id
  end

  def username_exists?(username)
    username == 'robertmkhall'
  end
end