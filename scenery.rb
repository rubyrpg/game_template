# frozen_string_literal: true

def create_scenery
  Rendering::RenderPipeline.set_skybox_colors(
    ground: Vector[0.2, 0.4, 0.8],
    horizon: Vector[0.7, 0.8, 0.9],
    sky: Vector[0.3, 0.5, 0.8]
  )

  Engine::GameObject.create(
    name: "Direction Light",
    rotation: Vector[-45, 180, 30],
    components: [
      Engine::Components::DirectionLight.create(
        colour: Vector[1.4, 1.4, 1.2],
      )
    ])

  ground_material = Engine::Material.create(shader: Engine::Shader.default)
  ground_material.set_vec3("baseColour", Vector[0.2, 0.4, 0.8])
  ground_material.set_texture("normalMap", Engine::Texture.for("assets/tiles_normal.png"))
  ground_material.set_float("specularStrength", 0.9)
  ground_material.set_float("specularPower", 64.0)

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
end
