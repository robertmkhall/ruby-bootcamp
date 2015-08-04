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

=begin
Given the following price list and shopping list print out the total cost of 
the shopping list in pounds and pence
=end 

def replace_invalid_chars(price)
  decimalised = price[/[.]/] ? price : "0." + price 
  decimalised.gsub(/[£p]/, '').to_f
end

def split_prices(prices) 
  split = prices.split.select { |item| item != '='}
  without_invalids = split.map { |item| item[/\d/] ? replace_invalid_chars(item) : item}
  Hash[*without_invalids]  
end

def calc_total(prices, shopping_list)
  filtered = shopping_list.split.select { |item| prices.has_key?(item) }
  filtered.inject(0.00) { |total, item| prices[item] + total } 
end

converted_prices = split_prices(price_list)
total = calc_total(converted_prices, shopping_list)

puts "The price of the shopping list is: £#{total}"