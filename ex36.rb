def gold_room
  puts "This room is full of gold. How much do you take?"

  print "> "
  choice = $stdin.gets.chomp 


while choice.to_i.to_s != choice do
  puts "That wasn't a number, try again."
  choice = $stdin.gets.chomp
end

how_much = choice.to_i


  if how_much < 50
    puts "Nice, you're not greedy, you win!"
    exit(0)
  else
    dead("You greedy bastard!")
  end
end

def dead(why)
  puts why, "Good job!"
  exit(0)
end

gold_room
