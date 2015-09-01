require 'pact/provider/rspec'
require 'app'
require 'billing_service'

Pact.service_provider 'Billing Service Producer' do
  ROOT = Pathname.new(File.expand_path(__dir__))
  BILL_PATH = ROOT.join("../resources").join('test_bill.json').to_s

  app { App.new({billing_service: BillingService.new(BILL_PATH)}) }
end