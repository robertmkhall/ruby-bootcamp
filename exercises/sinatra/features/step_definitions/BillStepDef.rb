require_relative '../support/env'
require 'support/matchers/html_matchers'

Then(/^these bill summary details will be displayed:$/) do |data|
  criteria = data.rows_hash
  
  expect(current_page.row(table: 'summary', row: 1)).to have_columns('Generated', criteria['Generated'])
  expect(current_page.row(table: 'summary', row: 2)).to have_columns('Due', criteria['Due'])
  expect(current_page.row(table: 'summary', row: 3)).to have_columns('From', criteria['From'])
  expect(current_page.row(table: 'summary', row: 4)).to have_columns('To', criteria['To'])
  expect(current_page.row(table: 'summary', row: 5)).to have_columns('Total', criteria['Total'])
end

Then(/^these '(.*)' will be displayed:$/) do |table_name, data|
  data.raw.each_index do |index|
    filtered = data.raw[index].select {|item| !item.empty?}
    expect(current_page.row(table: table_name, row: index + 1)).to have_columns(*filtered)
  end
end