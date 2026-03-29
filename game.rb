require "ruby_rpg"
require_relative "components/camera_controller"
require_relative "scenery"

AMBIENT_STRENGTH = 0.6

Engine.start do
  Rendering::PostProcessingEffect.add(
    Rendering::PostProcessingEffect.ssao(power: 1.4)
  )
  Rendering::PostProcessingEffect.add(
    Rendering::PostProcessingEffect.ssr(max_ray_distance: 15.0, ray_offset: 0.05, thickness: 1.0)
  )
  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[0, 1, 8],
    rotation: Vector[0, 0, 0],
    components: [
      Engine::Components::PerspectiveCamera.create(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 50.0),
      CameraController.create
    ])

  create_scenery

  colormap = Engine::Material.create(shader: Engine::Shader.default)
  colormap.set_vec3("baseColour", Vector[1, 1, 1])
  colormap.set_texture("image", Engine::Texture.for("assets/models/Textures/colormap.png"))
  colormap.set_float("ambientStrength", AMBIENT_STRENGTH)
  colormap.set_float("specularStrength", 0.1)
  colormap.set_float("roughness", 1.0)

  def self.prop(name, pos, material, rotation: Vector[0, 0, 0], scale: Vector[1, 1, 1])
    Engine::GameObject.create(
      name: name,
      pos: pos,
      rotation: rotation,
      scale: scale,
      components: [
        Engine::Components::MeshRenderer.create(
          mesh: Engine::Mesh.for("assets/models/#{name}"),
          material: material
        )
      ])
  end

  wall_material = Engine::Material.create(shader: Engine::Shader.default)
  wall_material.set_vec3("baseColour", Vector[0.6, 0.15, 0.15])
  wall_material.set_float("ambientStrength", AMBIENT_STRENGTH)
  wall_material.set_float("specularStrength", 0.1)
  wall_material.set_float("roughness", 1.0)

  # Surrounding walls (4 stretched cubes, 30x30 square centred at origin)
  Engine::StandardObjects::Cube.create(pos: Vector[0, 2, -15], scale: Vector[30, 5, 0.5], material: wall_material)   # back
  Engine::StandardObjects::Cube.create(pos: Vector[0, 2, 15], scale: Vector[30, 5, 0.5], material: wall_material)    # front
  Engine::StandardObjects::Cube.create(pos: Vector[-15, 2, 0], scale: Vector[0.5, 5, 30], material: wall_material)   # left
  Engine::StandardObjects::Cube.create(pos: Vector[15, 2, 0], scale: Vector[0.5, 5, 30], material: wall_material)    # right

  # Raised platform with stairs
  platform_material = Engine::Material.create(shader: Engine::Shader.default)
  platform_material.set_vec3("baseColour", Vector[0.75, 0.75, 0.75])
  platform_material.set_float("ambientStrength", AMBIENT_STRENGTH)
  platform_material.set_float("specularStrength", 0.1)
  platform_material.set_float("roughness", 1.0)

  Engine::StandardObjects::Cube.create(pos: Vector[0, 0.5, 0], scale: Vector[5, 1, 5], material: platform_material)

  # Front stairs
  (-1..1).each { |x| prop("stairs", Vector[x, 0, 3], colormap, rotation: Vector[0, -90, 0]) }
  # Back stairs
  (-1..1).each { |x| prop("stairs", Vector[x, 0, -3], colormap, rotation: Vector[0, 90, 0]) }
  # Left stairs
  (-1..1).each { |z| prop("stairs", Vector[-3, 0, z], colormap, rotation: Vector[0, 0, 0]) }
  # Right stairs
  (-1..1).each { |z| prop("stairs", Vector[3, 0, z], colormap, rotation: Vector[0, 180, 0]) }

  prop("flag", Vector[0, 1, 0], colormap)

  # Centre piece
  Engine::StandardObjects::Sphere.create(pos: Vector[0, 0.5, -5])
  prop("crate-color", Vector[2, 0, -7], colormap)
  prop("crate-color", Vector[2.5, 0, -7.5], colormap, rotation: Vector[0, 30, 0])
  prop("crate-color", Vector[2.2, 1, -7.2], colormap, rotation: Vector[0, 15, 0])
  prop("vehicle", Vector[-8, 0, -8], colormap, rotation: Vector[0, 45, 0])
  prop("coin", Vector[0, 1, -8], colormap)
  prop("weapon-sword", Vector[4, 0.5, -7], colormap, rotation: Vector[0, 0, -45])

  # Roofed strip at the back
  Engine::StandardObjects::Cube.create(
    pos: Vector[0, 4, -12.5],
    scale: Vector[30, 0.3, 5],
    material: wall_material
  )

  # Spot light pointing down
  Engine::GameObject.create(
    name: "Spot Light",
    pos: Vector[0, 3.8, -13.5],
    rotation: Vector[-90, 0, 0],
    components: [
      Engine::Components::SpotLight.create(
        range: 20,
        colour: Vector[1.0, 0.9, 0.7],
        inner_angle: 25,
        outer_angle: 40
      )
    ])

  # Animals
  prop("animal-dog", Vector[3, 0, -3], colormap, rotation: Vector[0, -30, 0])
  prop("animal-horse", Vector[-10, 0, -10], colormap, rotation: Vector[0, 60, 0])

  # Figurine on a pedestal
  prop("shape-cylinder", Vector[7, 0, -10], colormap, scale: Vector[1.5, 0.3, 1.5])
  prop("figurine", Vector[7, 0.3, -10], colormap)
end
