module Farming
  module Scenery
    def self.place(name, pos, rotation: Vector[0, 0, 0], scale: Vector[1, 1, 1], material: nature_mat)
      Engine::GameObject.create(
        name: name,
        pos: pos,
        rotation: rotation,
        scale: scale,
        components: [
          Engine::Components::MeshRenderer.create(
            mesh: Engine::Mesh.for("assets/nature/#{name}"),
            material: material
          )
        ])
    end

    def self.create
      Rendering::RenderPipeline.set_skybox_colors(
        ground: Vector[0.2, 0.35, 0.15],
        horizon: Vector[0.6, 0.75, 0.55],
        sky: Vector[0.4, 0.65, 0.9],
        ground_y: -0.1,
        horizon_y: 0.0,
        sky_y: 0.3
      )

      Engine::GameObject.create(
        name: "Sun",
        rotation: Vector[-50, 150, 0],
        components: [
          Engine::Components::DirectionLight.create(
            colour: Vector[1.3, 1.25, 0.95],
            cast_shadows: true,
            shadow_distance: 30.0
          )
        ])

      create_ground
      create_fields
      create_crops
      create_decorations
    end

    def self.create_ground
      # Grass base: 24x24 grid centered on origin
      (-12..11).each do |x|
        (-12..11).each do |z|
          place("ground_grass", Vector[x, 0, z])
        end
      end
    end

    def self.create_fields
      # 4 fields in a 2x2 layout, each 4x4 dirt tiles
      # with a 1-tile path gap between them
      #
      #   field1 (NW)    field2 (NE)
      #        path (cross + straight)
      #   field3 (SW)    field4 (SE)
      #
      # Fields centered around origin:
      #   NW: x=-4..-1, z=-4..-1
      #   NE: x= 1.. 4, z=-4..-1
      #   SW: x=-4..-1, z= 1.. 4
      #   SE: x= 1.. 4, z= 1.. 4

      field_positions = [
        { ox: -4, oz: -4 },  # NW (far left, far back)
        { ox:  1, oz: -4 },  # NE (far right, far back)
        { ox: -4, oz:  1 },  # SW (far left, near)
        { ox:  1, oz:  1 },  # SE (far right, near)
      ]

      field_positions.each do |field|
        4.times do |dx|
          4.times do |dz|
            place("crops_dirtDoubleRow", Vector[field[:ox] + dx, 0.001, field[:oz] + dz], material: field_mat)
          end
        end
      end

      # Paths between the fields
      # Horizontal path (along X) at z = -0.5 and z = 0.5
      (-4..4).each do |x|
        place("ground_pathStraight", Vector[x, 0.001, 0], rotation: Vector[0, 90, 0])
      end

      # Vertical path (along Z) at x = -0.5 and x = 0.5
      (-4..4).each do |z|
        place("ground_pathStraight", Vector[0, 0.001, z])
      end

      # Cross in the center
      place("ground_pathCross", Vector[0, 0.002, 0])
    end

    def self.create_crops
      # Field 1 (NW) - Wheat
      (-4..-1).each do |x|
        (-4..-1).each do |z|
          place("crops_wheatStageB", Vector[x, -0.05, z], material: crop_mat)
        end
      end

      # Field 2 (NE) - Corn at various stages
      corn_stages = %w[crops_cornStageA crops_cornStageB crops_cornStageC crops_cornStageD]
      (1..4).each do |x|
        (-4..-1).each_with_index do |z, i|
          place(corn_stages[i], Vector[x, -0.05, z], material: crop_mat)
        end
      end

      # Field 3 (SW) - Carrots and turnips
      (-4..-1).each do |x|
        (1..4).each do |z|
          crop = (x + z).even? ? "crop_carrot" : "crop_turnip"
          place(crop, Vector[x, -0.05, z], material: crop_mat)
        end
      end

      # Field 4 (SE) - Pumpkins and melons
      (1..4).each do |x|
        (1..4).each do |z|
          crop = (x + z).even? ? "crop_pumpkin" : "crop_melon"
          place(crop, Vector[x, -0.05, z], material: crop_mat)
        end
      end
    end

    def self.create_decorations
      # Trees near the farm
      trees = %w[tree_oak tree_default tree_detailed tree_fat tree_simple]
      [[-7, -7], [-7, 0], [-7, 6], [7, -7], [7, 0], [7, 6], [0, -7], [3, 7]].each_with_index do |(x, z), i|
        place(trees[i % trees.length], Vector[x, 0, z])
      end

      # Tree line around the perimeter to break up the skyline
      treeline = [
        # North side
        ["tree_oak",      -8.7, -9.3], ["tree_simple",   -8.1, -10.1], ["tree_tall",    -7.1, -8.8],
        ["tree_cone",     -6.5, -9.7], ["tree_detailed", -5.8, -9.5],  ["tree_thin",    -5.0, -10.2],
        ["tree_cone",     -4.2, -8.7], ["tree_default",  -3.6, -9.8],  ["tree_fat",     -2.9, -9.4],
        ["tree_oak",      -2.1, -10.0],["tree_simple",   -1.3, -8.9],  ["tree_tall",    -0.5, -9.7],
        ["tree_thin",      0.4, -9.6], ["tree_detailed",  1.1, -10.3], ["tree_oak",      1.7, -8.8],
        ["tree_fat",       2.5, -9.9], ["tree_default",   3.2, -9.2],  ["tree_cone",     3.9, -10.1],
        ["tree_fat",       4.6, -8.6], ["tree_simple",    5.3, -9.8],  ["tree_tall",     5.9, -9.4],
        ["tree_thin",      6.5, -10.0],["tree_detailed",  7.1, -9.0],  ["tree_oak",      7.8, -9.6],
        ["tree_cone",      8.3, -8.7], ["tree_default",   8.9, -9.5],
        # South side
        ["tree_default",  -8.4,  9.1], ["tree_oak",      -7.8,  9.8], ["tree_thin",    -7.2,  9.6],
        ["tree_fat",      -6.4, 10.1], ["tree_oak",      -5.5,  8.8], ["tree_cone",    -4.8,  9.5],
        ["tree_tall",     -4.1,  9.3], ["tree_detailed", -3.3, 10.0], ["tree_fat",     -2.6,  9.7],
        ["tree_simple",   -1.9,  8.9], ["tree_detailed", -1.2,  8.9], ["tree_tall",    -0.4,  9.8],
        ["tree_simple",    0.3,  9.4], ["tree_thin",      0.9, 10.2], ["tree_cone",     1.8,  9.0],
        ["tree_default",   2.6,  9.7], ["tree_oak",       3.4,  9.5], ["tree_fat",      4.1, 10.1],
        ["tree_thin",      4.7,  8.7], ["tree_tall",      5.4,  9.6], ["tree_default",  6.1,  9.2],
        ["tree_cone",      6.8, 10.0], ["tree_fat",       7.5,  9.6], ["tree_simple",   8.1,  8.8],
        ["tree_tall",      8.6,  8.9], ["tree_oak",       9.2,  9.5],
        # West side
        ["tree_detailed", -9.4, -7.3], ["tree_fat",     -10.1, -6.5], ["tree_simple",  -8.8, -5.6],
        ["tree_tall",     -9.7, -4.8], ["tree_oak",      -9.6, -3.9], ["tree_thin",   -10.2, -3.1],
        ["tree_cone",     -8.7, -2.1], ["tree_default",  -9.5, -1.3], ["tree_tall",    -9.3, -0.4],
        ["tree_oak",     -10.0,  0.4], ["tree_fat",      -8.9,  1.3], ["tree_detailed",-9.8,  2.0],
        ["tree_thin",     -9.5,  2.8], ["tree_cone",     -8.7,  3.6], ["tree_default", -8.6,  4.5],
        ["tree_simple",   -9.4,  5.3], ["tree_oak",      -9.2,  6.1], ["tree_tall",   -10.1,  6.8],
        ["tree_detailed", -8.8,  7.6], ["tree_fat",      -9.6,  8.3],
        # East side
        ["tree_fat",       9.3, -7.5], ["tree_cone",     10.0, -6.7], ["tree_oak",      8.7, -5.8],
        ["tree_simple",    9.6, -5.0], ["tree_tall",      9.5, -4.1], ["tree_default", 10.2, -3.3],
        ["tree_simple",    8.9, -2.3], ["tree_thin",      9.7, -1.5], ["tree_cone",     9.2, -0.6],
        ["tree_oak",      10.0,  0.2], ["tree_detailed",  9.6,  1.1], ["tree_fat",      8.8,  1.9],
        ["tree_default",   8.8,  2.7], ["tree_tall",      9.5,  3.5], ["tree_thin",     9.4,  4.4],
        ["tree_cone",     10.1,  5.2], ["tree_fat",       8.6,  6.0], ["tree_simple",   9.3,  6.7],
        ["tree_oak",       9.1,  7.4], ["tree_detailed", 10.0,  8.1],
      ]
      scales = [0.8, 1.0, 1.2, 0.9, 1.1, 0.7, 1.3, 1.0, 0.85, 1.15, 0.75, 1.25, 0.95, 1.05]
      treeline.each_with_index do |(type, x, z), i|
        s = scales[i % scales.length]
        place(type, Vector[x, 0, z], scale: Vector[s, s, s])
      end

      # Fences along the farm perimeter
      # Fence mesh sits at +Z edge of cell; rotated 90° sits at +X edge
      # # Front and back rows (full length)
      # (-6..5).each do |x|
      #   place("fence_simple", Vector[x, 0, 5])    # front
      #   place("fence_simple", Vector[x, 0, -6])   # back
      # end
      # # Side fences (skip corner cells where front/back already are)
      # (-5..4).each do |z|
      #   place("fence_simple", Vector[-5, 0, z], rotation: Vector[0, 90, 0])  # left
      #   place("fence_simple", Vector[6, 0, z], rotation: Vector[0, 90, 0])   # right
      # end
      # Front (south) fence between corners
      (-4..4).each do |x|
        place("fence_simple", Vector[x, 0, 5])
      end

      # East fence between corners
      (-4..4).each do |z|
        place("fence_simple", Vector[5, 0, z], rotation: Vector[0, -90, 0])
      end

      # North fence between corners
      (-4..4).each do |x|
        place("fence_simple", Vector[x, 0, -5], rotation: Vector[0, 180, 0])
      end

      # West fence between corners
      (-4..4).each do |z|
        place("fence_simple", Vector[-5, 0, z], rotation: Vector[0, 90, 0])
      end

      # Corner pieces
      place("fence_corner", Vector[-5, 0, 5])                                  # front-left
      place("fence_corner", Vector[5, 0, 5], rotation: Vector[0, -90, 0])     # front-right
      place("fence_corner", Vector[-5, 0, -5], rotation: Vector[0, 90, 0])    # back-left
      place("fence_corner", Vector[5, 0, -5], rotation: Vector[0, 180, 0])    # back-right

      # Tractor parked by the fields
      Engine::GameObject.create(
        name: "tractor",
        pos: Vector[-7, 0, 3],
        rotation: Vector[0, 45, 0],
        components: [
          Engine::Components::MeshRenderer.create(
            mesh: Engine::Mesh.for("assets/vehicles-kit/tractor"),
            material: vehicle_mat
          )
        ])

      # Farm props
      place("log_stack", Vector[6, 0, -3])
      place("pot_large", Vector[6, 0, 4])
      place("pot_small", Vector[6.5, 0, 3.5])
      place("sign", Vector[-3, 0, 6], rotation: Vector[0, 180, 0])
      place("stump_round", Vector[7, 0, 0])
      place("campfire_stones", Vector[7, 0, -6])

      # Animals
      place_animal("animal-horse", Vector[-7, 0, -2], rotation: Vector[0, 60, 0])
      place_animal("animal-dog", Vector[7, 0, 2], rotation: Vector[0, -45, 0])
      place_animal("animal-bison", Vector[-7, 0, -5], rotation: Vector[0, 30, 0])
      place_animal("animal-horse", Vector[7, 0, -4], rotation: Vector[0, -90, 0])
    end

    def self.place_animal(name, pos, rotation: Vector[0, 0, 0])
      Engine::GameObject.create(
        name: name,
        pos: pos,
        rotation: rotation,
        components: [
          Engine::Components::MeshRenderer.create(
            mesh: Engine::Mesh.for("assets/animals/#{name}"),
            material: prototype_mat
          )
        ])
    end

    # -- Materials --

    def self.nature_mat
      @nature_mat ||= begin
        # vertex_lit: these models use per-vertex colours baked into the mesh, not UV textures
        mat = Engine::Material.create(shader: Engine::Shader.vertex_lit)
        mat.set_float("roughness", 1.0)
        mat.set_float("diffuseStrength", 0.5)
        mat.set_float("specularStrength", 0.1)
        mat.set_float("specularPower", 32.0)
        mat
      end
    end

    def self.vehicle_mat
      @vehicle_mat ||= begin
        # default: UV-mapped model with a colour texture
        mat = Engine::Material.create(shader: Engine::Shader.default)
        mat.set_vec3("baseColour", Vector[1, 1, 1])
        mat.set_texture("image", Engine::Texture.for("assets/textures/car-colormap.png"))
        mat.set_float("ambientStrength", 0.5)
        mat.set_float("specularStrength", 0.3)
        mat.set_float("roughness", 0.8)
        mat
      end
    end

    def self.prototype_mat
      @prototype_mat ||= begin
        # default: UV-mapped model with a colour texture
        mat = Engine::Material.create(shader: Engine::Shader.default)
        mat.set_vec3("baseColour", Vector[1, 1, 1])
        mat.set_texture("image", Engine::Texture.for("assets/textures/colormap.png"))
        mat.set_float("ambientStrength", 0.5)
        mat.set_float("specularStrength", 0.1)
        mat.set_float("roughness", 1.0)
        mat
      end
    end

    def self.field_mat
      @field_mat ||= begin
        # vertex_lit: dirt tiles use per-vertex colours, not UV textures
        mat = Engine::Material.create(shader: Engine::Shader.vertex_lit)
        mat.set_float("roughness", 0.15)
        mat.set_float("diffuseStrength", 0.5)
        mat.set_float("specularStrength", 2.0)
        mat.set_float("specularPower", 16.0)
        mat
      end
    end

    def self.crop_mat
      @crop_mat ||= begin
        # vertex_lit: crop models use per-vertex colours, not UV textures
        mat = Engine::Material.create(shader: Engine::Shader.vertex_lit)
        mat.set_float("roughness", 0.8)
        mat.set_float("diffuseStrength", 0.5)
        mat.set_float("specularStrength", 0.3)
        mat.set_float("specularPower", 32.0)
        mat
      end
    end
  end
end
