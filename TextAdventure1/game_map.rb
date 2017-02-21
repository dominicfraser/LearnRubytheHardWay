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

