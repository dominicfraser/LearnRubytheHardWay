class Character

  def initialize(type)
    @type = type
  end

  @base_strength = 0
  base_health = 0
  base_agility = 0

  case @type 
  when @type == "brute"
    base_strength += 70
    base_health += 60
    base_agility += 40
  when @type == "rouge"
    base_strength += 50
    base_health += 50
    base_agility += 70
  when @type == "cleric"
    base_strength += 40
    base_health += 80
    base_agility += 50
  else
    puts "There has been an error creating this character" 
  end
end

puts "Please choose a character type:"
chartypeselection = gets.chomp
Character.new("chartypeselection")
puts "Great!"
puts "Your Base Strength is #{base_strength}"

