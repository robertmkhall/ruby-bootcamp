require_relative '../support/env'
require 'support/matchers/html_matchers'

Then(/^these '(.*)' will be displayed:$/) do |table_name, data|
  data.raw.each_index do |index|
    filtered = data.raw[index].select { |item| !item.empty? }
    expect(current_page.row(table: table_name, row: index + 1)).to have_columns(*filtered)
  end
end