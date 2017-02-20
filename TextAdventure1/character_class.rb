class Character

  attr_accessor :base_strength
  attr_accessor :base_health
  attr_accessor :base_agility 

  def initialize(type)
    @type = type
    @base_strength = 0
    @base_health = 0
    @base_agility = 0


    case @type 
    when "brute"
      @base_strength += 70
      @base_health += 60
      @base_agility += 40
    when "rouge"
      @base_strength += 50
      @base_health += 50
      @base_agility += 70
    when "cleric"
      @base_strength += 40
      @base_health += 80
      @base_agility += 50
    else
      puts "Please select brute, rouge, or cleric." 
    end
  end
end