class CharacterType 

  def initialize(type)
    @type = type
  end

  base_strength = 0
  base_health = 0
  base_agility = 0

  if type == brute {
    base_strength += 70
    base_health += 60
    base_agility += 40
  elsif type == rouge
    base_strength += 50
    base_health += 50
    base_agility += 70
  elsif
    type == cleric
    base_strength += 40
    base_health += 80
    base_agility += 50
  else
    puts "There has been an error creating this character" 
    }

end


def Player < CharacterType

  def initialize()
  end

  base_strength
  base_health
  base_agility


  damage = 
  defence =
  agility =

end
