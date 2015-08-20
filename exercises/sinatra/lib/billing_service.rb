require 'pathname'

class BillingService

  ROOT = Pathname.new(File.expand_path(__dir__))
  BILLS_PATH = ROOT.join("resources").to_s
  BILL_FILE_NAME = 'bill.json'

  def bill
    read_bill(BILL_FILE_NAME)
  end

  def read_bill(filename)
    file = File.read(BILLS_PATH + filename)
    JSON.parse(file)
  end
end