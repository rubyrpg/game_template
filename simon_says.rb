require "ruby_rpg"
require_relative "simon_says/clickable_sphere"
require_relative "simon_says/scene"

Engine.start do
  Rendering::PostProcessingEffect.add(
    Rendering::PostProcessingEffect.bloom(blur_scale: 3.0)
  )

  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[0, 0, 8],
    components: [
      Engine::Components::OrthographicCamera.create(width: 8.0 * (1920.0 / 1080.0), height: 8.0, far: 50.0)
    ])

  SimonSays::Scene.create
end
