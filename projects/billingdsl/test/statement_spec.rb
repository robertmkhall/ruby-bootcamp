require_relative '../lib/statement'
require 'date'

describe Statement do

  it 'will create a Statement with correct variables' do

    statement = Statement.new do
      self.date = Date.today
      # date Date.today
      # due(date + 30)
    end

    expect(statement.attributes[:date]).to eql(Date.today)
  end
end