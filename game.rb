require "ruby_rpg"

Engine.start do
  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[0, 0, 0],
    rotation: Vector[0, 0, 0],
    components: [
      Engine::Components::PerspectiveCamera.create(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 1000.0)
    ])

  Engine::GameObject.create(
    name: "Direction Light",
    rotation: Vector[-60, 180, 30],
    components: [
      Engine::Components::DirectionLight.create(
        colour: Vector[1.4, 1.4, 1.2],
      )
    ])

  Engine::StandardObjects::Sphere.create(pos: Vector[0, 0, -10])
end
