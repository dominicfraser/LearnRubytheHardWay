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
              
      

      elsif action == "LEAVE"
        puts "building burns down"
        @visited_blacksmith = true
        puts "hope no one saw"
      else
        puts "didn't understand"
        puts "something went wrong"
      end
    end

    puts "this wouldnt be seen as redirect"
    return "signboard"
  end
end


puts "Please choose a character type:"
chartypeselection = gets.chomp
Player = Character.new(chartypeselection)


game = Blacksmith.new()
game.enter()
