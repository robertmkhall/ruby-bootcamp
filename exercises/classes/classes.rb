# encoding: ISO-8859-1

price_list = "orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34" 

shopping_list=<<LIST
 list
 orange
 apple
 apple
 orange
 tomato
 cereal
 bread
 orange
 tomato
LIST


class Till

  attr_reader :total

  def initialize(catalogue)
    @total = 0
    @catalogue = catalogue
  end

  def scan_item(item)
    @total = total + @catalogue.price(item);
  end
end


class Catalogue

  def self.new_from_string(price_string)
    self.new(CatalogueConverter.convert_price_string_to_hash(price_string))
  end

  def initialize(prices) 
    @prices = prices
    @prices.default = 0.00
  end 

  def price(item)
    @prices[item]
  end
end

class CatalogueConverter

  def self.fix_price_values(price)
    decimalised = price[/[.]/] ? price : "0." + price
    decimalised.gsub(/[£p]/, '').to_f
  end

  def self.convert_price_string_to_hash(price_string)
    split = price_string.split.select { |item| item != '='}
    withoutInvalids = split.map { |item| item[/\d/] ? fix_price_values(item) : item }
    Hash[*withoutInvalids]
  end
end

till = Till.new(Catalogue.new_from_string(price_list))

shopping_list.split.each do |item| till.scan_item(item) end

puts "Total price is: £#{till.total}"
