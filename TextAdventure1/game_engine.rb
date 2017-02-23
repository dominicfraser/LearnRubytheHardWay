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

puts "Please choose a character type:"
chartypeselection = gets.chomp
player = Character.new(chartypeselection)

a_map = GameMap.new("opening_scene")
a_game = GameEngine.new(a_map, player)

