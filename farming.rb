require "ruby_rpg"
require_relative "farming/scenery"

Engine.start do
  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[0, 12, 12],
    rotation: Vector[50, 0, 0],
    components: [
      Engine::Components::PerspectiveCamera.create(fov: 35.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 50.0)
    ])

  Farming::Scenery.create
end
