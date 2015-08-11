require_relative '../lib/call'

describe Call do

  it 'will create a Call with the correct attributes' do

    call = Call.new('07716393769') do
      date Date.parse('2015-02-01')
      duration "00:23:03"
      cost 1.13
    end

    expect(call.called).to eql('07716393769')
    expect(call.date.to_s).to eql('2015-02-01')
    expect(call.duration).to eql('00:23:03')
    expect(call.cost).to eql(1.13)
  end

  it 'will create a call when no block provided' do
    call = Call.new('077163935433')

    expect(call.called).to eql('077163935433')
  end

  it 'will generate accurate json' do
    call = Call.new('07716393769') do
      date Date.parse('2015-02-01')
      duration "00:23:03"
      cost 1.13
    end

    expected_json = "{ \"called\": \"07716393769\", \"date\": \"2015-02-01\", \"duration\": \"00:23:03\", \"cost\": 1.13}"

    actual_json = call.to_json

    expect(actual_json).to eql(expected_json)
  end
end