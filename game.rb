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

  # Open area props
  prop("coin", Vector[5, 1, -5], colormap)
  prop("weapon-sword", Vector[-5, 0.5, -5], colormap, rotation: Vector[0, 0, -45])

  # Under the lights (x = -10, -5, 0, 5, 10 at z = -13.5)
  prop("vehicle", Vector[-10, 0, -13.5], colormap, rotation: Vector[0, 45, 0])
  prop("crate-color", Vector[-5, 0, -13.5], colormap)
  prop("crate-color", Vector[-4.5, 0, -13], colormap, rotation: Vector[0, 30, 0])
  prop("crate-color", Vector[-4.8, 1, -13.2], colormap, rotation: Vector[0, 15, 0])
  prop("animal-dog", Vector[-0.5, 0, -13.5], colormap, rotation: Vector[0, -30, 0])
  prop("animal-horse", Vector[1, 0, -13.5], colormap, rotation: Vector[0, 60, 0])
  prop("weapon-sword", Vector[5, 0.5, -13.5], colormap, rotation: Vector[0, 0, -45])

  # Roofed strip at the back
  Engine::StandardObjects::Cube.create(
    pos: Vector[0, 4, -12.5],
    scale: Vector[30, 0.3, 5],
    material: wall_material
  )

  # Spotlights along the roofed strip
  spot_colours = [
    Vector[1.0, 0.3, 0.3],  # red
    Vector[0.3, 1.0, 0.3],  # green
    Vector[0.3, 0.3, 1.0],  # blue
    Vector[1.0, 1.0, 0.3],  # yellow
    Vector[1.0, 0.3, 1.0],  # magenta
  ]
  spot_colours.each_with_index do |colour, i|
    x = -10 + i * 5
    Engine::GameObject.create(
      name: "Spot Light #{i}",
      pos: Vector[x, 3.8, -13.5],
      rotation: Vector[-90, 0, 0],
      components: [
        Engine::Components::SpotLight.create(
          range: 15,
          colour: colour,
          inner_angle: 15,
          outer_angle: 30,
          cast_shadows: true
        )
      ])
  end

  # Under magenta light
  prop("shape-cylinder", Vector[10, 0, -13.5], colormap, scale: Vector[1.5, 0.3, 1.5])
  prop("figurine", Vector[10, 0.3, -13.5], colormap)

  # Shapes gallery along front wall
  prop("shape-cube", Vector[-10, 0, 13], colormap)
  prop("shape-cube-half", Vector[-7, 0, 13], colormap)
  prop("shape-cube-rounded", Vector[-4, 0, 13], colormap)
  prop("shape-cylinder", Vector[-1, 0, 13], colormap)
  prop("shape-hexagon", Vector[2, 0, 13], colormap)
  prop("shape-slope", Vector[5, 0, 13], colormap)
  prop("shape-triangular-prism", Vector[8, 0, 13], colormap)
  prop("shape-hollow-cylinder", Vector[11, 0, 13], colormap)
  prop("shape-hollow-hexagon", Vector[-13, 0, 13], colormap)

  # Small building (front-right corner)
  bx, bz = 9, 9

  # L-shaped wall
  prop("wall", Vector[bx, 0, bz + 0.4], colormap, rotation: Vector[0, -90, 0])
  prop("wall-window-medium", Vector[bx + 1, 0, bz + 0.4], colormap, rotation: Vector[0, -90, 0])
  prop("wall-corner", Vector[bx + 2, 0, bz], colormap, rotation: Vector[0, 90, 0])
  prop("wall", Vector[bx + 2.4, 0, bz - 1], colormap)
  prop("wall-doorway", Vector[bx + 2.4, 0, bz - 2], colormap)

  # Furniture
  prop("crate-color", Vector[bx + 0.3, 0, bz], colormap, rotation: Vector[0, 20, 0])
  prop("pipe", Vector[bx + 1.8, 0, bz + 0.2], colormap)
  prop("lever-single", Vector[bx + 2, 0, bz - 1.5], colormap)
end
