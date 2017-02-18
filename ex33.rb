i = 0

puts "What would you like the largest possible number to be?"
largest = gets.chomp.to_i

puts "What would you like the increment to be?"
inc = gets.chomp.to_i

numbers = []

while i < largest
  puts "At the top i is #{i}"
  numbers.push(i)

  i += inc

  puts "Numbers now: ", numbers
  puts "At the bottom i is #{i}"
end

puts "The numbers: "

