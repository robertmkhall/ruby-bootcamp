prices = {
      'orange' => 10,
      'apple' => 20,
      'bread' => 100,
      'tomato' => 25,
      'cereal' => 234
}

shopping_list = [:orange, :apple, :apple, :cereal, :bread]

def calcTotal(prices, shoppingList)
  '%.2f' % shoppingList.inject(0.00) { |total, item| prices[item.to_s] + total } 
end

total = calcTotal(prices, shopping_list)
puts "The price of the shopping list is: #{total}"

