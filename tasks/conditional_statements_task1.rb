def forSum(nums)
  sum = 0

  nums.each do |num|
    sum += num
  end

  sum
end

def whileSum(nums)
  sum = 0
  index = 0
  
  until index == nums.length
    sum += nums[index]
    index += 1
  end
  
  sum
end

def recurSum(nums)
  nums.first ? nums.first + recurSum(nums.drop(1)) : 0
end

puts "for loop sum #{forSum([1, 2, 3])}"
puts "while loop sum #{whileSum([4,5,6])}"
puts "recurrsive loop sum #{recurSum([1,5,10,20])}"
