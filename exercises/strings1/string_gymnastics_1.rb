# encoding: ISO-8859-1

prices = {
      'orange' => 10,
      'apple' => 20,
      'bread' => 100,
      'tomato' => 25,
      'cereal' => 234
} 

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


def calcTotal(prices, shoppingList)
  filtered = shoppingList.split.select { |item| prices.has_key?(item) }
  "%.2f" % filtered.inject(0.00) { |total, item| prices[item] + total } 
end

total = calcTotal(prices, shopping_list)
puts "The price of the shopping list is: £#{total}"