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
    items_held = {}
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
       @base_health += 80
       @base_agility += 50
     else
       puts "Please select brute, rouge, or cleric." 
     end
  end

  def add_item(item_called)
    attribute_to_change = item_called.item_changes
    attribute_changes_by = item_called.by_amount
    
    puts item_called.item_desc
    puts attribute_to_change
    puts attribute_changes_by

    if attribute_to_change == "strength"
      @base_strength += attribute_changes_by
    elsif attribute_to_change == "health"
      @base_health += attribute_changes_by
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

class GameEngine 
  def initialize(scenes)
    @scenes = scenes
  end

  def play()
    current_scene = @scenes.opening_scene()
    last_scene = @scenes.next_scene("completed")

    while current_scene != last_scene
      next_scene_name = current_scene.enter()
      current_scene = @scenes.next_scene(next_scene_name)
    end

  current_scene.enter()
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

a_map = GameMap.new("opening_scene")
a_game = GameEngine.new(a_map)
a_game.play() 


puts "Please choose a character type:"
chartypeselection = gets.chomp
Player = Character.new(chartypeselection)

