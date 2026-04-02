module Props
  def self.colormap
    @colormap ||= begin
      mat = Engine::Material.create(shader: Engine::Shader.default)
      mat.set_vec3("baseColour", Vector[1, 1, 1])
      mat.set_texture("image", Engine::Texture.for("assets/textures/colormap.png"))
      mat.set_float("ambientStrength", AMBIENT_STRENGTH)
      mat.set_float("specularStrength", 0.1)
      mat.set_float("roughness", 1.0)
      mat
    end
  end

  def self.place(category, name, pos, rotation: Vector[0, 0, 0], scale: Vector[1, 1, 1], components: [])
    Engine::GameObject.create(
      name: name,
      pos: pos,
      rotation: rotation,
      scale: scale,
      components: [
        Engine::Components::MeshRenderer.create(
          mesh: Engine::Mesh.for("assets/#{category}/#{name}"),
          material: colormap
        ),
        *components
      ])
  end

  def self.create_platform
    platform_material = Engine::Material.create(shader: Engine::Shader.default)
    platform_material.set_vec3("baseColour", Vector[0.75, 0.75, 0.75])
    platform_material.set_float("ambientStrength", AMBIENT_STRENGTH)
    platform_material.set_float("specularStrength", 0.1)
    platform_material.set_float("roughness", 1.0)

    Engine::StandardObjects::Cube.create(pos: Vector[0, 0.5, 0], scale: Vector[5, 1, 5], material: platform_material)

    (-1..1).each { |x| place("buildings", "stairs", Vector[x, 0, 3], rotation: Vector[0, -90, 0]) }
    (-1..1).each { |x| place("buildings", "stairs", Vector[x, 0, -3], rotation: Vector[0, 90, 0]) }
    (-1..1).each { |z| place("buildings", "stairs", Vector[-3, 0, z]) }
    (-1..1).each { |z| place("buildings", "stairs", Vector[3, 0, z], rotation: Vector[0, 180, 0]) }

    place("props", "flag", Vector[0, 1, 0])
  end

  def self.create_light_display
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

    place("vehicles", "vehicle", Vector[-10, 0, -13.5], rotation: Vector[0, 45, 0])
    place("props", "crate-color", Vector[-5, 0, -13.5])
    place("props", "crate-color", Vector[-4.5, 0, -13], rotation: Vector[0, 30, 0])
    place("props", "crate-color", Vector[-4.8, 1, -13.2], rotation: Vector[0, 15, 0], components: [BobAndSpin.create])
    place("animals", "animal-dog", Vector[-0.5, 0, -13.5], rotation: Vector[0, -30, 0])
    place("animals", "animal-horse", Vector[1, 0, -13.5], rotation: Vector[0, 60, 0])
    place("props", "weapon-sword", Vector[5, 0.5, -13.5], rotation: Vector[0, 0, -45], components: [BobAndSpin.create])
    place("geometry", "shape-cylinder", Vector[10, 0, -13.5], scale: Vector[1.5, 0.3, 1.5])
    place("props", "figurine", Vector[10, 0.3, -13.5])
  end

  def self.create_shapes_gallery
    place("geometry", "shape-cube", Vector[-10, 0, 13])
    place("geometry", "shape-cube-half", Vector[-7, 0, 13])
    place("geometry", "shape-cube-rounded", Vector[-4, 0, 13])
    place("geometry", "shape-cylinder", Vector[-1, 0, 13])
    place("geometry", "shape-hexagon", Vector[2, 0, 13])
    place("geometry", "shape-slope", Vector[5, 0, 13])
    place("geometry", "shape-triangular-prism", Vector[8, 0, 13])
    place("geometry", "shape-hollow-cylinder", Vector[11, 0, 13])
    place("geometry", "shape-hollow-hexagon", Vector[-13, 0, 13])
  end

  def self.create_building
    bx, bz = 9, 9

    place("buildings", "wall", Vector[bx, 0, bz + 0.4], rotation: Vector[0, -90, 0])
    place("buildings", "wall-window-medium", Vector[bx + 1, 0, bz + 0.4], rotation: Vector[0, -90, 0])
    place("buildings", "wall-corner", Vector[bx + 2, 0, bz], rotation: Vector[0, 90, 0])
    place("buildings", "wall", Vector[bx + 2.4, 0, bz - 1])
    place("buildings", "wall-doorway", Vector[bx + 2.4, 0, bz - 2])

    place("props", "crate-color", Vector[bx + 0.3, 0, bz], rotation: Vector[0, 20, 0])
    place("buildings", "pipe", Vector[bx + 1.8, 0, bz + 0.2])
    place("indicators", "lever-single", Vector[bx + 2, 0, bz - 1.5])
    place("props", "coin", Vector[bx + 1, 0.5, bz - 1], components: [BobAndSpin.create])
  end

  def self.create_bloom_spheres
    hdr_colours = [
      Vector[1.0, 0.085, 0.085],  # red
      Vector[0.085, 1.0, 0.085],  # green
      Vector[0.085, 0.085, 1.5],  # blue
      Vector[1.0, 0.85, 0.085],   # amber
      Vector[1.0, 0.085, 0.85],   # pink
      Vector[0.085, 0.85, 1.0],   # cyan
      Vector[1.0, 1.0, 1.0],    # white
    ]
    hdr_colours.each_with_index do |colour, i|
      mat = Engine::Material.create(shader: Engine::Shader.colour)
      mat.set_vec3("colour", colour * 4.5)
      mat.set_float("roughness", 1.0)

      pos = Vector[-13, 2, -8 + i * 3]

      Engine::StandardObjects::Sphere.create(
        pos: pos,
        material: mat
      )

      Engine::GameObject.create(
        name: "Bloom Light #{i}",
        pos: pos,
        components: [
          Engine::Components::PointLight.create(
            range: 8,
            colour: colour * 0.08
          )
        ])
    end
  end
end
