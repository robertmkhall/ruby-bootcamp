require_relative '../lib/statement'
require 'date'
require 'active_support/all'

describe Statement do

  it 'will create a Statement with correct attributes' do

    statement = Statement.new do
      date Date.today
      due(date + 30.days)
      from Date.parse('2015-01-26')
      to Date.parse('2015-02-25')

      call_charges do
        call '07716393769' do
          date Date.parse('2015-02-01')
          duration "00:23:03"
          cost 1.13
        end
      end
    end

    expect(statement.date).to eql(Date.today)
    expect(statement.due).to eql(Date.today + 30)
    expect(statement.from.to_s).to eql('2015-01-26')
    expect(statement.to.to_s).to eql('2015-02-25')

    call_charges = statement.call_charges
    expect(call_charges.calls.size).to eql(1)

    call = call_charges.calls[0]
    expect(call.tel_number).to eql('07716393769')
    expect(call.date.to_s).to eql('2015-02-01')
    expect(call.duration).to eql('00:23:03')
    expect(call.cost).to eql(1.13)
  end

  it 'will output accurate json' do
    expected_json = '{
  "statement": {
    "date": "2015-01-11",
    "due": "2015-01-25",
    "period": {
      "from": "2015-01-26",
      "to": "2015-02-25"
    },
    "total": 1.23,
    "callCharges": {
      "calls": [
        { "called": "07716393769", "date": "2015-01-26", "duration": "00:23:03", "cost": 1.13 },
        { "called": "07716393769", "date": "2015-01-26", "duration": "00:23:03", "cost": 0.20 }

      ]
    }
  }
}'

    statement = Statement.new do
      date Date.parse('2015-01-11')
      due Date.parse('2015-01-25')
      from Date.parse('2015-01-16')
      to Date.parse('2015-01-25')

      call_charges do
        call '07716393769' do
          date Date.parse('2015-02-01')
          duration "00:23:03"
          cost 1.13
        end
      end
    end

    actual_json = statement.to_json

    expect(actual_json).to eql(expected_json)
  end
end