# frozen_string_literal: true

def create_scenery
  Engine::GameObject.create(
    name: "Direction Light",
    rotation: Vector[-60, 180, 30],
    components: [
      Engine::Components::DirectionLight.create(
        colour: Vector[1.4, 1.4, 1.2],
      )
    ])

  ground_material = Engine::Material.create(shader: Engine::Shader.default)
  ground_material.set_vec3("baseColour", Vector[0.2, 0.4, 0.8])

  Engine::StandardObjects::Plane.create(
    pos: Vector[0, -2, 0],
    rotation: Vector[90, 0, 0],
    scale: Vector[100, 100, 100],
    material: ground_material
  )
end
