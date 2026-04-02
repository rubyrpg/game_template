require "ruby_rpg"
require_relative "simon_says/clickable_sphere"
require_relative "simon_says/score_text"
require_relative "simon_says/colour_button"
require_relative "simon_says/scene"

Engine.start do
  Engine::Cursor.enable

  Rendering::PostProcessingEffect.add(
    Rendering::PostProcessingEffect.bloom(blur_scale: 3.0)
  )

  Rendering::RenderPipeline.set_skybox_colors(
    ground: Vector[0.05, 0.05, 0.1],
    horizon: Vector[0.1, 0.1, 0.15],
    sky: Vector[0.05, 0.05, 0.1],
    ground_y: -0.1,
    horizon_y: 0.0,
    sky_y: 0.3
  )

  SimonSays::Scene.create
end
