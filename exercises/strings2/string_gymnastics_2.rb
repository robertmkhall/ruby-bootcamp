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

def replaceInvalidChars(price)
  decimalised = price[/[.]/] ? price : "0." + price 
  decimalised.gsub(/[£p]/, '').to_f
end

def splitPrices(prices) 
  split = prices.split.select { |item| item != '='}
  withoutInvalids = split.map { |item| item[/\d/] ? replaceInvalidChars(item) : item}
  Hash[*withoutInvalids]  
end

def calcTotal(prices, shoppingList)
  filtered = shoppingList.split.select { |item| prices.has_key?(item) }
  filtered.inject(0.00) { |total, item| prices[item] + total } 
end

convertedPrices = splitPrices(price_list)
total = calcTotal(convertedPrices, shopping_list)

puts "The price of the shopping list is: £#{total}"