require 'pathname'
require 'json'

class BillingService

  ROOT = Pathname.new(File.expand_path(__dir__))
  BILL_PATH = ROOT.join("../resources").join('bill.json').to_s

  attr_reader :bill_path

  def initialize(bill_path = BILL_PATH)
    puts "bill path = #{bill_path}"
    @bill_path = bill_path
  end

  def bill
    file = File.read(bill_path)
    JSON.parse(file)
  end
end