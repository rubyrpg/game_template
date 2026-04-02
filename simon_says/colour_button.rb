module SimonSays
  module ColourButton
    def self.create(pos, colour)
      mat = Engine::Material.create(shader: Engine::Shader.colour)
      mat.set_vec3("colour", colour * ClickableSphere::DIM_MULTIPLIER)
      mat.set_float("roughness", 1.0)

      Engine::StandardObjects::Sphere.create(
        pos: pos,
        material: mat,
        components: [
          ClickableSphere.create(colour: colour, material: mat)
        ]
      )
    end
  end
end
