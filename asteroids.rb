require "ruby_rpg"
require_relative "asteroids/ship_engine"
require_relative "asteroids/wrap_around"
require_relative "asteroids/camera"
require_relative "asteroids/score_text"
require_relative "asteroids/ship"
require_relative "asteroids/asteroid"
require_relative "asteroids/shield"
require_relative "asteroids/explosion"
require_relative "asteroids/bullet"
require_relative "asteroids/scene"

Engine.start do
  Rendering::RenderPipeline.set_skybox_colors(
    ground: Vector[0, 0, 0],
    horizon: Vector[0, 0, 0],
    sky: Vector[0, 0, 0]
  )

  Asteroids::Scene.create
end
