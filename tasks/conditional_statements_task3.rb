def fibonacciComputer 
  fibSeq = [0,1]

  (1..98).each do |index|
    fib = fibSeq[index-1] + fibSeq[index]
    fibSeq.push(fib)
  end

  fibSeq
end

puts "Fibonacci sequence for first 100 numbers: #{fibonacciComputer}"
