# frozen_string_literal: true

module Farming
  module Scenery
    def self.nature_mat
      @nature_mat ||= begin
        mat = Engine::Material.create(shader: Engine::Shader.vertex_lit)
        mat.set_float("roughness", 1.0)
        mat.set_float("diffuseStrength", 0.5)
        mat.set_float("specularStrength", 0.1)
        mat.set_float("specularPower", 32.0)
        mat
      end
    end

    def self.place(name, pos, rotation: Vector[0, 0, 0], scale: Vector[1, 1, 1])
      Engine::GameObject.create(
        name: name,
        pos: pos,
        rotation: rotation,
        scale: scale,
        components: [
          Engine::Components::MeshRenderer.create(
            mesh: Engine::Mesh.for("assets/nature/#{name}"),
            material: nature_mat
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
            place("crops_dirtDoubleRow", Vector[field[:ox] + dx, 0.001, field[:oz] + dz])
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
          place("crops_wheatStageB", Vector[x, 0.05, z])
        end
      end

      # Field 2 (NE) - Corn at various stages
      corn_stages = %w[crops_cornStageA crops_cornStageB crops_cornStageC crops_cornStageD]
      (1..4).each do |x|
        (-4..-1).each_with_index do |z, i|
          place(corn_stages[i], Vector[x, 0.05, z])
        end
      end

      # Field 3 (SW) - Carrots and turnips
      (-4..-1).each do |x|
        (1..4).each do |z|
          crop = (x + z).even? ? "crop_carrot" : "crop_turnip"
          place(crop, Vector[x, 0.05, z])
        end
      end

      # Field 4 (SE) - Pumpkins and melons
      (1..4).each do |x|
        (1..4).each do |z|
          crop = (x + z).even? ? "crop_pumpkin" : "crop_melon"
          place(crop, Vector[x, 0.05, z])
        end
      end
    end

    def self.create_decorations
      # Trees around the edges
      trees = %w[tree_oak tree_default tree_detailed tree_fat tree_simple]
      [[-6, -6], [-6, 0], [-6, 5], [5, -6], [5, 0], [5, 5], [0, -6], [0, 5]].each_with_index do |(x, z), i|
        place(trees[i % trees.length], Vector[x, 0, z])
      end

      # Fences along the farm perimeter
      (-5..4).each do |x|
        place("fence_simple", Vector[x, 0, -5])
        place("fence_simple", Vector[x, 0, 6])
      end
      (-5..5).each do |z|
        place("fence_simple", Vector[-5, 0, z], rotation: Vector[0, 90, 0])
        place("fence_simple", Vector[5, 0, z], rotation: Vector[0, 90, 0])
      end
    end
  end
end
