print "How much did you make today? "
earnings = gets.chomp.to_i

puts "Thanks. \nHere is your commission."
commission = (earnings * 0.1).round(2)
puts "(They hand you £#{commission}.)"
