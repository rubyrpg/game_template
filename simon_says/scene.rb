module SimonSays
  module Scene
    def self.create
      create_camera
      ScoreText.create

      ColourButton.create(Vector[-1.5, 1.5, 0],  Vector[1.0, 0.1, 0.1])
      ColourButton.create(Vector[1.5, 1.5, 0],   Vector[0.1, 1.0, 0.1])
      ColourButton.create(Vector[-1.5, -1.5, 0], Vector[0.1, 0.1, 1.5])
      ColourButton.create(Vector[1.5, -1.5, 0],  Vector[1.0, 1.0, 0.1])
    end

    def self.create_camera
      Engine::GameObject.create(
        name: "Camera",
        pos: Vector[0, 0, 8],
        components: [
          Engine::Components::OrthographicCamera.create(width: 8.0 * (1920.0 / 1080.0), height: 8.0, far: 50.0)
        ]
      )
    end
  end
end
