def combineList(list1, list2) 
  expectedSize = list1.size + list2.size 
  combined = []

  cnt = 0
  until cnt >= list1.size && cnt >= list2.size
    combined.push(list1[cnt]) if list1[cnt]
    combined.push(list2[cnt]) if list2[cnt]
    cnt += 1 
  end

  combined
end

list1 = [10, 20, 30, 40, 50]
list2 = ["cats", "dogs", "fish"]

combined = combineList(list1, list2)

puts "combined lists #{list1} and #{list2} is #{combined}"
