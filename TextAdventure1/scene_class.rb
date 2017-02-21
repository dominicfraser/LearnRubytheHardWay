class Scene
  attr_accessor :visited_pumpkin
  attr_accessor :visited_blacksmith

  def initialize
    @visited_pumpkin = false
    @visited_blacksmith = false
  end

  def enter()
    puts "Scene not set up yet, set it up!"
    exit(1)
  end
end

class OpeningScene < Scene
  def enter()
    puts "welcome message"
    return "signboard"
  end
end

class Signboard < Scene
  def enter()
    puts "where do you want to go?"
    puts "PUMPKINPATCH, BLACKSMITH, MONSTER"
    where = gets.chomp.upcase

    if where == "PUMPKINPATCH"
      puts "pumpkins"
      return "pumpkin_patch"
    elsif where == "BLACKSMITH"
      puts "blacksmith"
      return "blacksmith"
    elsif where == "MONSTER"
      puts "monster"
      return "monster"
    else
      puts "invalid"
      return "signboard"
    end
  end
end

class PumpkinPatch < Scene

  def enter()
    while @visited_pumpkin == false
        puts "welcome to pumpkin patch"
        puts "you can CATCH or THROW pumpkins"
        puts "which would you like to do?"

        action = gets.chomp.upcase

        if action == "CATCH"
          puts "now you catch"
          Player.base_agility += 10
          @visited_pumpkin = true
          return "signboard"

        elsif action == "THROW"
          puts "now you throw"
          Player.base_strength += 10
          @visited_pumpkin = true
          return "signboard"

        else 
          puts "invalid"
          return "pumpkin_patch"
        end
    end

    puts "You've been here before! Season over."
    return "signboard"
  end
end

class Blacksmith < Scene

  def enter 
    while @visited_blacksmith == false
      armour = Item.new("body_armour", "health", 20)
      sword = Item.new("a_sword", "strength", 20)
      #how do I make the above visible if I create them 
      #outside of this method??

      puts "welcome blacksmith message"
      puts "choose HELP or LEAVE"

      action = gets.chomp.upcase

      if action == "HELP"
        puts "you chose to help"
        @visited_blacksmith = true
        puts "you put out the fire"
        puts "Blacksmith offers you either some ARMOUR or a SWORD"
        choice = gets.chomp.upcase
          if choice == "ARMOUR"
            Player.add_item(armour)
            puts Player.base_health
          elsif choice == "SWORD"
            Player.add_item(sword)
            puts Player.base_strength
          else
            puts "didn't understand"
            choice = gets.chomp.upcase
          end
        return "signboard"

      elsif action == "LEAVE"
        puts "building burns down"
        @visited_blacksmith = true
        return "signboard"
      else
        puts "didn't understand"
        return "blacksmith"
      end
    end

    puts "Been to blacksmith before"
    return "signboard"
  end
end

class Monster < Scene
  def initialize
    @fighting = true
    @damage_this_round = Player.base_strength + rand(1..10)
    @your_health = Player.base_health
    @monster_health = 300
  end

  def did_you_hit 
    if rand(1..10) < ( Player.base_agility / 10 )
      return true
    else
      return false
    end
  end

  def it_strikes
      if rand(1..10) > ( Player.base_agility / 10 - 2 )
        @your_health -= 15
        if @your_health <= 0
          @fighting = false
        else
          puts "It hits you but you're still standing."
        end
      else
        puts "It missed!"
      end
  end

  def enter 
    while @fighting
      
      if did_you_hit == true
        @monster_health -= @damage_this_round
        puts "You hit it!"
        if @monster_health <= 0
          @fighting = false
        else
          puts "It tries to hit you!"
          it_strikes
        end

      else
        puts "You missed!"
        puts "It tries to hit you!"
        it_strikes
      end
    end

    if @your_health <= 0
      return "death"
    else
      return "completed"
     end

  end
end

class Death < Scene
  def enter 
    puts "You died.  Good job!"
    exit(1)
  end
end

class Completed < Scene
  def enter
    puts "You won! Good job."
  end
end

