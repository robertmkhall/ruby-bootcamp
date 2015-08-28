describe 'bill.slim' do

  include_context :slim_templates

  subject(:session) { BillPage.new(render(bill: bill)) }

  let(:bill) do
    ROOT = Pathname.new(File.expand_path(__dir__))
    BILL_PATH = ROOT.join("../resources").join('test_bill.json').to_s

    file = File.read(BILL_PATH)
    JSON.parse(file)
  end

  #TODO - check currency output with £ and 2 decimals

  it 'displays the bill statement' do
    expect(page).to have_table('summary')
    expect(session.row(table: 'summary', row: 1)).to have_columns('Generated', '2015-01-11')
    expect(session.row(table: 'summary', row: 2)).to have_columns('Due', '2015-01-25')
    expect(session.row(table: 'summary', row: 3)).to have_columns('From', '2015-01-26')
    expect(session.row(table: 'summary', row: 4)).to have_columns('To', '2015-02-25')
    expect(session.row(table: 'summary', row: 5)).to have_columns('Total', '136.03')

    expect(page).to have_table('subscriptions')
    expect(session.row(table: 'subscriptions', row: 1)).to have_columns('tv', 'Variety with Movies HD', 50.00)
    expect(session.row(table: 'subscriptions', row: 2)).to have_columns('talk', 'Sky Talk Anytime', 5.00)
    expect(session.row(table: 'subscriptions', row: 3)).to have_columns('broadband', 'Fibre Unlimited', 16.40)
    expect(session.row(table: 'subscriptions', row: 4)).to have_columns('Total', '71.4')

    expect(page).to have_table('calls')
    expect(session.row(table: 'calls', row: 1)).to have_columns('07716393769', '00:23:03', 2.13)
    expect(session.row(table: 'calls', row: 2)).to have_columns('07716393999', '00:08:11', 1.22)
    expect(session.row(table: 'calls', row: 3)).to have_columns('07716393888', '00:15:03', 1.87)
    expect(session.row(table: 'calls', row: 4)).to have_columns('Total', '5.22')

    expect(page).to have_table('purchases')
    expect(session.row(table: 'purchases', row: 1)).to have_columns('Rental', '50 Shades of Grey', 4.99)
    expect(session.row(table: 'purchases', row: 2)).to have_columns('Purchase', 'Thats what she said', 9.99)
    expect(session.row(table: 'purchases', row: 3)).to have_columns('Purchase', 'Broke back mountain', 9.99)
    expect(session.row(table: 'purchases', row: 4)).to have_columns('Total', '24.97')
  end
end