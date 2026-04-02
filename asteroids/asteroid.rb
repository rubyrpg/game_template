# frozen_string_literal: true

module Asteroids
  module Asteroid
    def self.create(pos, variant: 1)
      material = Engine::Material.create(shader: Engine::Shader.instanced_sprite)
      material.set_texture("image", Engine::Texture.for("assets/Asteroid_0#{variant}.png"))
      material.set_vec4("spriteColor", [1, 1, 1, 1])

      Engine::GameObject.create(
        name: "Asteroid_0#{variant}",
        pos: pos,
        scale: Vector[50, 50, 50],
        components: [
          Engine::Components::SpriteRenderer.create(material: material)
        ]
      )
    end
  end
end
