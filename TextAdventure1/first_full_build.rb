#Bugs:
#go_on is not DRY
#health can show a minus number when dead
#put text descriptions of increasing stats back in when leveling up
#items are built inside the Blacksmith class, hard to expand the game that way

class Character

  attr_accessor :base_strength
  attr_accessor :base_health
  attr_accessor :base_agility 

  def initialize(type)
    @type = type
    @base_strength = 0
    @base_health = 0
    @base_agility = 0
    self.chooseclass
    #items_held = [] use on later version?
  end

  def chooseclass
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
       @base_health += 90
       @base_agility += 50
     else
       puts "Please select BRUTE, ROUGE, or CLERIC." 
       chartypeselection = gets.chomp
       puts "\n"
       player = Character.new(chartypeselection)
       a_map = GameMap.new("opening_scene")
       a_game = GameEngine.new(a_map, player)
       a_game.play() 
     end
  end

  def add_item(item_called)
    attribute_to_change = item_called.item_changes
    attribute_changes_by = item_called.by_amount

    if attribute_to_change == "strength"
      @base_strength += attribute_changes_by
      puts "\nYou feel like you can inflict more damage now!"
      puts " "
    elsif attribute_to_change == "health"
      @base_health += attribute_changes_by
      puts "You feel able to take more hits now!"
      puts " "
    elsif
      attribute_to_change == "agility"
      @base_agility += attribute_changes_by
    else
      puts "error adding item"
    end
   end
end

class Item
  attr_reader :item_desc 
  attr_reader :item_changes
  attr_reader :by_amount

# item_changes MUST be strength/ health/ agility to work
  def initialize(item_desc, item_changes, by_amount)
    @item_desc = item_desc
    @item_changes = item_changes
    @by_amount = by_amount
  end
end

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
    puts "Great!\nYou are about to enter Hamilton.\nThis small town has recently been plauged by a terrifying monster!\nWill you take it upon yourself to challenge this dreadful beast?\nOnly time will tell if you are up to it!\n\nBest of luck to you young wanderer!"
    go_on = gets.chomp

    return "signboard"
  end
end

class Signboard < Scene
  def enter(player)
    puts "You arrive at the signboard in the middle of town.\nIt has three 'wanted' adds:"
    go_on = gets.chomp
    puts "One for an apprentice BLACKSMITH.\nOne looking for a farmhand to help in a nearby PUMPKIN PATCH.\nOne imploring for help to rid the town of a MONSTER."
    puts "\nIt's probably best to get some experience before heading to a fight."
    go_on = gets.chomp
    puts "Which direction would you like to take?"
    puts "To the PUMPKIN PATCH, BLACKSMITH, or MONSTER?"
    where = gets.chomp.upcase

    if where.include?("PUMP") == true
      return "pumpkin_patch"
    elsif where.include?("BLACK")
      return "blacksmith"
    elsif where.include?("MON")
      return "monster"
    else
      puts "You try to go to #{where} but can't quite find it.\nYou wander around lost for a bit."
      go_on = gets.chomp
      return "signboard"
    end
  end
end

class PumpkinPatch < Scene

  def enter(player)

    @player = player

    while @visited_pumpkin == false
        puts "\nYou arrive at the PUMPKIN PATCH.\nThe farmer immediately spots you.\nHe calls over to you."
        go_on = gets.chomp
        puts "'Hey there! We need a hand, get over here!'\nYou see you can either CATCH or THROW pumpkins."
        puts "Which would you like to do?"

        action = gets.chomp.upcase

        if action == "CATCH"
          puts "\nYou help the chain to CATCH.\nYou drop a few, but soon feel your accuracy improving.\nAfter a nights rest at the farm you head back to Hamilton."
          go_on = gets.chomp
          player.base_agility += 10
          @visited_pumpkin = true
          return "signboard"

        elsif action == "THROW"
          puts "\nYou help the chain to THROW.\nYou arms ache, but you can feel yourself getting stronger by the hour.\nAfter a nights rest at the farm you head back to Hamilton."
          go_on = gets.chomp
          player.base_strength += 10
          @visited_pumpkin = true
          return "signboard"

        else 
          puts "You go to walk on by, but a farmhand sends you back."
          go_on = gets.chomp
          return "pumpkin_patch"
        end
    end

    puts "\nYou've been here before!\nAll the ripe pumpkins have been picked."
    go_on = gets.chomp
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

      puts "\nAs you approach the Blacksmith you see smoke.\nIt is on fire!"
      puts "Do you HELP or LEAVE?"

      action = gets.chomp.upcase

      if action == "HELP"
        @visited_blacksmith = true
        puts "\nYou rush over and start helping bring water over.\nFinally it subsides and you take a break."
        puts "The Blacksmith comes over and thanks you for your help.\nHe doesn't need an extra apprentice now!\nHe wants to offer you something for your help."
        go_on = gets.chomp
        puts "The Blacksmith offers you either some ARMOUR or a SWORD."
        puts "Which do you choose?"
        choice = gets.chomp.upcase
          if choice == "ARMOUR"
            player.add_item(armour)
          elsif choice == "SWORD"
            puts player.base_strength
          else
            puts "Seems you mumbled a little and missed your chance!"
            go_on = gets.chomp
          end
        return "signboard"

      elsif action == "LEAVE"
        puts "Oh dear. Without your help the building burns down.\nHope no one noticed you!"
        go_on = gets.chomp
        @visited_blacksmith = true
        return "signboard"
      else
        puts "\nYou take another look around, but head back to the Blacksmith."
        go_on = gets.chomp
        return "blacksmith"
      end
    end

    puts "You've been here before!\nThe Blacksmith certainly doesn't need an apprentice now!"
    go_on = gets.chomp
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
        puts "It hits you! Your health is now #{@player.base_health}."
        if @player.base_health <= 0
          @fighting = false
        else
          puts "You're still standing, you rush it again!"
        end
      else
        puts "It missed!"
        puts "You attack again!"
      end
  end

  def enter(player) 
    @player = player
    @damage_this_round = player.base_strength + rand(1..10)
    puts "\nYou follow the tracks to a cave.\nThere's no going back now!\nAs you go in a dark shape moves forwards.\nAs it comes into the light you see that is is...\nA giant guinea pig! What is this madness!\nIt comes at you and you have to fight!"
    go_on = gets.chomp

    puts "Your strength is #{player.base_strength}"
    puts "Your health is #{player.base_health}"
    puts "Your agility is #{player.base_agility}"
    go_on = gets.chomp
    puts "You rush in!"
    while @fighting
      
      if did_you_hit == true
        @monster_health -= @damage_this_round
        puts "You hit it!"
        puts "Its health is #{@monster_health}"
        if @monster_health <= 0
          @fighting = false
        else
          puts "It tries to hit you!"
          go_on = gets.chomp

          it_strikes
        end

      else
        puts "You missed!"
        puts "It tries to hit you!"
        go_on = gets.chomp

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
    puts "\nYou died.  Who knew guinea pigs were so deadly!"
    exit(1)
  end
end

class Completed < Scene
  def enter(player)
    puts "\nYou won! Good job."
  end
end

class GameEngine 
  def initialize(scenes, current_player)
    @scenes = scenes
    @current_player = current_player
  end

  def play()
    current_scene = @scenes.opening_scene()
    last_scene = @scenes.next_scene("completed")

    while current_scene != last_scene
      next_scene_name = current_scene.enter(@current_player)
      current_scene = @scenes.next_scene(next_scene_name)
    end

  current_scene.enter(@current_player)
  end
end

class GameMap
  @@scene_options = {
    "opening_scene" => OpeningScene.new(),
    "signboard" => Signboard.new(),
    "pumpkin_patch" => PumpkinPatch.new(),
    "blacksmith" => Blacksmith.new(),
    "monster" => Monster.new(),
    "death" => Death.new(),
    "completed" => Completed.new(),
  }

  def initialize(start_scene)
    @start_scene = start_scene
  end

  def next_scene(scene_name)
    direction_choice = @@scene_options[scene_name]
    return direction_choice
  end

  def opening_scene()
    return next_scene(@start_scene)
  end
end

puts "Welcome adventurer!"
go_on = gets.chomp
puts "Please choose a character type: \nYou can be either a BRUTE, a ROUGE, or a CLERIC."
puts "\nBRUTES are tough and strong, but slow. \nROUGES are nimble and fast. \nCLERICS have a wealth of useful knowledge about healing."
puts "\nWhich do you choose to be?"
chartypeselection = gets.chomp
puts "\n"
player = Character.new(chartypeselection)

a_map = GameMap.new("opening_scene")
a_game = GameEngine.new(a_map, player)
a_game.play() 