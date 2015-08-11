require_relative '../lib/call_charges'

describe CallCharges do

  it 'will create a CallCharges with the specified calls' do
    call_charges = CallCharges.new do
      call '07716393769' do
        date Date.parse('2015-02-01')
        duration "00:23:03"
        cost 1.13
      end
      call '07716323232' do
        date Date.parse('2015-03-01')
        duration "04:29:19"
        cost 1.99
      end
    end

    expect(call_charges.calls.size).to eql(2)

    eval_call(call_charges.calls[0], '07716393769', '2015-02-01', '00:23:03', 1.13)
    eval_call(call_charges.calls[1], '07716323232', '2015-03-01', '04:29:19', 1.99)
  end

  it 'will generate accurate json' do
    expected_json = '
    "callCharges": {
      "calls": [
        { "called": "07716393769", "date": "2015-01-26", "duration": "00:23:03", "cost": 1.13 },
        { "called": "07716393769", "date": "2015-02-12", "duration": "00:23:03", "cost": 0.20 }
      ]
  }
}'

    call_charges = CallCharges.new do
        call '07716393769' do
          date Date.parse('2015-01-26')
          duration "00:23:03"
          cost 1.13
        end
        call '07716393769' do
          date Date.parse('2015-02-12')
          duration "00:23:03"
          cost 0.20
        end
      end

    actual_json = call_charges.to_json

    expect(actual_json).to eql(expected_json)
  end

  def eval_call(call, *args)
    expect(call.called).to eql(args[0])
    expect(call.date.to_s).to eql(args[1])
    expect(call.duration).to eql(args[2])
    expect(call.cost).to eql(args[3])
  end
end