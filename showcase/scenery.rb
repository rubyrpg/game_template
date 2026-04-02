module Scenery
  def self.wall_material
    @wall_material ||= begin
      mat = Engine::Material.create(shader: Engine::Shader.default)
      mat.set_vec3("baseColour", Vector[0.6, 0.15, 0.15])
      mat.set_float("ambientStrength", AMBIENT_STRENGTH)
      mat.set_float("specularStrength", 0.1)
      mat.set_float("roughness", 1.0)
      mat
    end
  end

  def self.create
    Rendering::RenderPipeline.set_skybox_colors(
      ground: Vector[0.1, 0.1, 0.3],
      horizon: Vector[0.7, 0.8, 0.9],
      sky: Vector[0.3, 0.5, 0.8],
      ground_y: -0.1,
      horizon_y: 0.0,
      sky_y: 0.3
    )

    Engine::GameObject.create(
      name: "Direction Light",
      rotation: Vector[-45, -40, 0],
      components: [
        Engine::Components::DirectionLight.create(
          colour: Vector[1.4, 1.4, 1.2],
          cast_shadows: true,
          shadow_distance: 30.0
        )
      ])

    ground_material = Engine::Material.create(shader: Engine::Shader.default)
    ground_material.set_vec3("baseColour", Vector[0.1, 0.1, 0.3])
    ground_material.set_texture("normalMap", Engine::Texture.for("assets/textures/tiles_normal.png"))
    ground_material.set_float("specularStrength", 0.9)
    ground_material.set_float("specularPower", 64.0)
    ground_material.set_float("roughness", 0.7)
    ground_material.set_float("ambientStrength", AMBIENT_STRENGTH)

    tile_size = 5
    grid_size = 10
    offset = (grid_size * tile_size) / 2.0 - tile_size / 2.0

    grid_size.times do |x|
      grid_size.times do |z|
        Engine::StandardObjects::Plane.create(
          pos: Vector[x * tile_size - offset, 0, -(z * tile_size - offset)],
          rotation: Vector[90, 0, 0],
          scale: Vector[tile_size, tile_size, tile_size],
          material: ground_material
        )
      end
    end

    # Surrounding walls
    Engine::StandardObjects::Cube.create(pos: Vector[0, 2, -15], scale: Vector[30, 5, 0.5], material: wall_material)
    Engine::StandardObjects::Cube.create(pos: Vector[0, 2, 15], scale: Vector[30, 5, 0.5], material: wall_material)
    Engine::StandardObjects::Cube.create(pos: Vector[-15, 2, 0], scale: Vector[0.5, 5, 30], material: wall_material)
    Engine::StandardObjects::Cube.create(pos: Vector[15, 2, 0], scale: Vector[0.5, 5, 30], material: wall_material)

    # Roof strip at the back
    Engine::StandardObjects::Cube.create(
      pos: Vector[0, 4, -12.5],
      scale: Vector[30, 0.3, 5],
      material: wall_material
    )
  end
end
