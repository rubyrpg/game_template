module Asteroids
  module Explosion
    FRAMES = [
      { tl: Vector[1.0 / 6, 0], width: 1.0 / 6, height: 1 },
      { tl: Vector[2.0 / 6, 0], width: 1.0 / 6, height: 1 },
      { tl: Vector[3.0 / 6, 0], width: 1.0 / 6, height: 1 },
      { tl: Vector[4.0 / 6, 0], width: 1.0 / 6, height: 1 },
      { tl: Vector[5.0 / 6, 0], width: 1.0 / 6, height: 1 },
      { tl: Vector[0, 0], width: 1.0 / 6, height: 1 },
    ]

    def self.create(pos)
      material = Engine::Material.create(shader: Engine::Shader.instanced_sprite)
      material.set_texture("image", Engine::Texture.for("assets/boom.png"))
      material.set_vec4("spriteColor", [1, 1, 1, 1])

      Engine::GameObject.create(
        name: "Explosion",
        pos: pos,
        scale: Vector[50, 50, 50],
        components: [
          Engine::Components::SpriteRenderer.create(material: material),
          Engine::Components::SpriteAnimator.create(
            material: material,
            frame_coords: FRAMES,
            frame_rate: 10,
            loop: true
          )
        ]
      )
    end
  end
end
