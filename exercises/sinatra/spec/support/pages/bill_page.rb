require 'page_magic'

class BillPage
  include PageMagic

  element :table_value do |table:, row:, col:|
    selector xpath: "//table[@id='#{table}']//tr[#{row}]/td[#{col}]"
  end

  element :row do |table:, row:|
    selector xpath: "//table[@id='#{table}']//tr[#{row}]"
  end
end