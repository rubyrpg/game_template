module Asteroids
  module Scene
    def self.create
      create_camera
      ScoreText.create
      Ship.create(Vector[Engine::Window.framebuffer_width / 2, Engine::Window.framebuffer_height / 2, 0])
      Asteroid.create(Vector[100, 200, 0], variant: 1)
      Asteroid.create(Vector[200, 200, 0], variant: 2)
      Asteroid.create(Vector[300, 200, 0], variant: 3)
      Asteroid.create(Vector[400, 200, 0], variant: 4)
      Shield.create(Vector[500, 200, 0])
      Explosion.create(Vector[600, 200, 0])
      Bullet.create(Vector[700, 200, 0])
    end

    def self.create_camera
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
