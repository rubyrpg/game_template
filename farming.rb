require "ruby_rpg"
require_relative "components/camera_controller"
require_relative "farming/scenery"

Engine.start do
  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[0, 1, 6],
    rotation: Vector[10, 0, 0],
    components: [
      Engine::Components::PerspectiveCamera.create(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 50.0),
      CameraController.create
    ])

  Farming::Scenery.create
end
