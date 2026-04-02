module Farming
  module Player
    def self.create
      Engine::GameObject.create(
        name: "Camera",
        pos: Vector[0, 0.5, 4],
        rotation: Vector[10, 0, 0],
        components: [
          Engine::Components::PerspectiveCamera.create(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 50.0),
          WalkController.create
        ]
      )
    end
  end
end
