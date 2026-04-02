module SimonSays
  module Scene
    COLOURS = {
      red:    Vector[1.0, 0.1, 0.1],
      green:  Vector[0.1, 1.0, 0.1],
      blue:   Vector[0.1, 0.1, 1.5],
      yellow: Vector[1.0, 1.0, 0.1],
    }

    POSITIONS = {
      red:    Vector[-1.5, 1.5, 0],
      green:  Vector[1.5, 1.5, 0],
      blue:   Vector[-1.5, -1.5, 0],
      yellow: Vector[1.5, -1.5, 0],
    }

    def self.create
      Engine::Cursor.enable

      Rendering::RenderPipeline.set_skybox_colors(
        ground: Vector[0.05, 0.05, 0.1],
        horizon: Vector[0.1, 0.1, 0.15],
        sky: Vector[0.05, 0.05, 0.1],
        ground_y: -0.1,
        horizon_y: 0.0,
        sky_y: 0.3
      )

      Engine::GameObject.create(
        name: "Light",
        rotation: Vector[0, 0, 0],
        components: [
          Engine::Components::DirectionLight.create(
            colour: Vector[0.5, 0.5, 0.5],
            cast_shadows: false
          )
        ])

      Engine::GameObject.create(
        name: "ScoreText",
        components: [
          Engine::Components::UI::Rect.create(
            left_offset: 20,
            top_offset: 20,
            right_ratio: 1.0,
            bottom_ratio: 1.0,
            right_offset: -200,
            bottom_offset: -120
          ),
          Engine::Components::UI::FontRenderer.create(
            font: Engine::Font.press_start_2p,
            string: "Score: 0"
          )
        ]
      )

      COLOURS.each do |name, colour|
        mat = Engine::Material.create(shader: Engine::Shader.colour)
        mat.set_vec3("colour", colour * ClickableSphere::DIM_MULTIPLIER)
        mat.set_float("roughness", 1.0)

        Engine::StandardObjects::Sphere.create(
          pos: POSITIONS[name],
          material: mat,
          components: [
            ClickableSphere.create(colour: colour, material: mat)
          ]
        )

        Engine::GameObject.create(
          name: "#{name}_light",
          pos: POSITIONS[name],
          components: [
            Engine::Components::PointLight.create(
              range: 5,
              colour: colour * 0.05
            )
          ])
      end
    end
  end
end
