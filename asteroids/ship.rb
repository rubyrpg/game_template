module Asteroids
  module Ship
    def self.create(pos)
      # instanced_sprite: renders 2D sprites from a texture atlas
      material = Engine::Material.create(shader: Engine::Shader.instanced_sprite)
      material.set_texture("image", Engine::Texture.for("assets/Player.png"))
      material.set_vec4("spriteColor", [1, 1, 1, 1])

      Engine::GameObject.create(
        name: "Ship",
        pos: pos,
        scale: Vector[50, 50, 1],
        components: [
          ShipEngine.create,
          WrapAround.new,
          Engine::Components::SpriteRenderer.create(material: material)
        ]
      )
    end
  end
end
