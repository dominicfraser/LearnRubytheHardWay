class Scene
  attr_accessor :visited_pumpkin
  attr_accessor :visited_blacksmith

  def initialize
    @visited_pumpkin = false
    @visited_blacksmith = false
  end

  def enter(player)
    puts "Scene not set up yet, set it up!"
    exit(1)
  end
end

class OpeningScene < Scene
  def enter(player)
    puts "welcome message"
    return "signboard"
  end
end

class Signboard < Scene
  def enter(player)
    puts "where do you want to go?"
    puts "PUMPKINPATCH, BLACKSMITH, MONSTER"
    where = gets.chomp.upcase

    if where.include?("PUMP") == true
      puts "pumpkins"
      return "pumpkin_patch"
    elsif where.include?("BLACK")
      puts "blacksmith"
      return "blacksmith"
    elsif where.include?("MON")
      puts "monster"
      return "monster"
    else
      puts "invalid"
      return "signboard"
    end
  end
end

class PumpkinPatch < Scene

  def enter(player)

    @player = player

    while @visited_pumpkin == false
        puts "welcome to pumpkin patch"
        puts "you can CATCH or THROW pumpkins"
        puts "which would you like to do?"

        action = gets.chomp.upcase

        if action == "CATCH"
          puts "now you catch"
          player.base_agility += 10
          @visited_pumpkin = true
          return "signboard"

        elsif action == "THROW"
          puts "now you throw"
          player.base_strength += 10
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

  def enter(player)
    @player = player

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
            player.add_item(armour)
            puts player.base_health
          elsif choice == "SWORD"
            player.add_item(sword)
            puts player.base_strength
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
    @monster_health = 300
  end


  def did_you_hit 
    if rand(1..10) < ( @player.base_agility / 10 )
      return true
    else
      return false
    end
  end

  def it_strikes
      if rand(1..10) > ( @player.base_agility / 10 - 2 )
        @player.base_health -= 15
        puts "base health is #{@player.base_health}"
        if @player.base_health <= 0
          @fighting = false
        else
          puts "It hits you but you're still standing."
        end
      else
        puts "It missed!"
      end
  end

  def enter(player) 
    @player = player
    @damage_this_round = player.base_strength + rand(1..10)

    puts "Your strength is #{player.base_strength}"
    puts "Your health is #{player.base_health}"
    puts "Your agility is #{player.base_agility}"

    while @fighting
      
      if did_you_hit == true
        @monster_health -= @damage_this_round
        puts "You hit it!"
        puts "Its health is #{@monster_health}"
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

    if @player.base_health <= 0
      return "death"
    else
      return "completed"
     end

  end
end

class Death < Scene
  def enter(player) 
    puts "You died.  Good job!"
    exit(1)
  end
end

class Completed < Scene
  def enter(player)
    puts "You won! Good job."
  end
end