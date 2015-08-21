require 'pathname'

class BillingService

  ROOT = Pathname.new(File.expand_path(__dir__))
  BILL_PATH = ROOT.join("resources").join('bill.json').to_s

  def bill
    file = File.read(BILL_PATH)
    JSON.parse(file)
  end
end