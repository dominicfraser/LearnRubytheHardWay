puts "Enter words"
text = gets.chomp

puts " Enter word to redact: "
redact = gets.chomp

words = text.split (" ")

words = [ 'monday', 'tuesday', 'wednesday', 'thursday' ]

words.each do |word|
 
   if word == redact
       print "REDACTED "
   else
       print "word "
       
end
end