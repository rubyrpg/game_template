require "ruby_rpg"
require_relative "farming/walk_controller"
require_relative "farming/player"
require_relative "farming/scenery"

Engine.start do
  Engine::Cursor.disable

  Rendering::RenderPipeline.set_skybox_colors(
    ground: Vector[0.2, 0.35, 0.15],
    horizon: Vector[0.6, 0.75, 0.55],
    sky: Vector[0.4, 0.65, 0.9],
    ground_y: -0.1,
    horizon_y: 0.0,
    sky_y: 0.3
  )

  Farming::Player.create
  Farming::Scenery.create
end
