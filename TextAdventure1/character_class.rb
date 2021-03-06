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

puts "Please choose a character type:"
chartypeselection = gets.chomp
Player = Character.new(chartypeselection)