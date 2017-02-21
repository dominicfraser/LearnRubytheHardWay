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

Player = Character.new("rouge")

a_map = GameMap.new("opening_scene")
a_game = GameEngine.new(a_map)
a_game.play() 