first, second, third = ARGV

puts "Your first variable is: #{first}"
puts "Your second variable is: #{second}"
puts "Your third variable is: #{third}"

print "What else? "
fourth = $stdin.gets.chomp

puts "Your fourth variable is: #{fourth}"
