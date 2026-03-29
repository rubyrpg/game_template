require "ruby_rpg"
require_relative "components/camera_controller"
require_relative "scenery"

Engine.start do
  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[0, 0, 0],
    rotation: Vector[0, 0, 0],
    components: [
      Engine::Components::PerspectiveCamera.create(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 100.0),
      CameraController.create
    ])

  create_scenery

  Engine::StandardObjects::Sphere.create(pos: Vector[0, 0, -10])
end
