# frozen_string_literal: true

module Asteroids
  module Camera
    def self.create
      Engine::GameObject.create(
        name: "Camera",
        pos: Vector[Engine::Window.framebuffer_width / 2, Engine::Window.framebuffer_height / 2, 0],
        components: [
          Engine::Components::OrthographicCamera.create(
            width: Engine::Window.framebuffer_width, height: Engine::Window.framebuffer_height, far: 1000
          )
        ]
      )
    end
  end
end
