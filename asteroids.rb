require "ruby_rpg"
require_relative "asteroids/ship_engine"
require_relative "asteroids/wrap_around"

Engine.start do
  Rendering::RenderPipeline.set_skybox_colors(
    ground: Vector[0, 0, 0],
    horizon: Vector[0, 0, 0],
    sky: Vector[0, 0, 0]
  )

  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[Engine::Window.framebuffer_width / 2, Engine::Window.framebuffer_height / 2, 0],
    components: [
      Engine::Components::OrthographicCamera.create(
        width: Engine::Window.framebuffer_width, height: Engine::Window.framebuffer_height, far: 1000
      )
    ]
  )

  Engine::GameObject.create(
    name: "ScoreText",
    components: [
      Engine::Components::UI::Rect.create(
        left_offset: 20,
        top_offset: 20,
        right_ratio: 1.0,
        bottom_ratio: 1.0,
        right_offset: -200,
        bottom_offset: -120
      ),
      Engine::Components::UI::FontRenderer.create(
        font: Engine::Font.press_start_2p,
        string: "Score: 0"
      )
    ]
  )

  # Player ship — arrow keys / WASD to move, wraps around screen edges
  ship_material = Engine::Material.create(shader: Engine::Shader.instanced_sprite)
  ship_material.set_texture("image", Engine::Texture.for("assets/Player.png"))
  ship_material.set_vec4("spriteColor", [1, 1, 1, 1])

  Engine::GameObject.create(
    name: "Ship",
    pos: Vector[Engine::Window.framebuffer_width / 2, Engine::Window.framebuffer_height / 2, 0],
    scale: Vector[50, 50, 1],
    components: [
      ShipEngine.create,
      WrapAround.new,
      Engine::Components::SpriteRenderer.create(material: ship_material)
    ]
  )

  # Example sprites — asteroid variants, shield, explosion, and a square
  sprites = [
    "assets/Asteroid_01.png",
    "assets/Asteroid_02.png",
    "assets/Asteroid_03.png",
    "assets/Asteroid_04.png",
    "assets/Shield.png",
    "assets/boom.png",
    "assets/Square.png"
  ]

  explosion_frames = [
    { tl: Vector[1.0 / 6, 0], width: 1.0 / 6, height: 1 },
    { tl: Vector[2.0 / 6, 0], width: 1.0 / 6, height: 1 },
    { tl: Vector[3.0 / 6, 0], width: 1.0 / 6, height: 1 },
    { tl: Vector[4.0 / 6, 0], width: 1.0 / 6, height: 1 },
    { tl: Vector[5.0 / 6, 0], width: 1.0 / 6, height: 1 },
    { tl: Vector[0, 0], width: 1.0 / 6, height: 1 },
  ]

  spacing = 100
  total_width = (sprites.length - 1) * spacing
  start_x = (Engine::Window.framebuffer_width - total_width) / 2
  center_y = Engine::Window.framebuffer_height / 4

  sprites.each_with_index do |sprite_path, i|
    material = Engine::Material.create(shader: Engine::Shader.instanced_sprite)
    material.set_texture("image", Engine::Texture.for(sprite_path))
    material.set_vec4("spriteColor", [1, 1, 1, 1])

    components = [Engine::Components::SpriteRenderer.create(material: material)]

    if sprite_path == "assets/boom.png"
      components << Engine::Components::SpriteAnimator.create(
        material: material,
        frame_coords: explosion_frames,
        frame_rate: 10,
        loop: true
      )
    end

    Engine::GameObject.create(
      name: File.basename(sprite_path, ".png"),
      pos: Vector[start_x + i * spacing, center_y, 0],
      scale: Vector[50, 50, 50],
      components: components
    )
  end
end
