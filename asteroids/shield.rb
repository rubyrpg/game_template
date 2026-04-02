module Asteroids
  module Shield
    def self.create(pos)
      # instanced_sprite: renders 2D sprites from a texture atlas
      material = Engine::Material.create(shader: Engine::Shader.instanced_sprite)
      material.set_texture("image", Engine::Texture.for("assets/Shield.png"))
      material.set_vec4("spriteColor", [1, 1, 1, 1])

      Engine::GameObject.create(
        name: "Shield",
        pos: pos,
        scale: Vector[50, 50, 50],
        components: [
          Engine::Components::SpriteRenderer.create(material: material)
        ]
      )
    end
  end
end
