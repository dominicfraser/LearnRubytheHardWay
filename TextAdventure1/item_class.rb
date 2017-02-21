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

armour = Item.new("body_armour", "strength", 20)