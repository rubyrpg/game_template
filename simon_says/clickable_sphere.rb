class ClickableSphere < Engine::Component
  DIM_MULTIPLIER = 0.3
  LIT_MULTIPLIER = 3.0
  HOVER_RADIUS = 0.5

  serialize :colour, :material

  def start
    set_brightness(DIM_MULTIPLIER)
  end

  def update(delta_time)
    mouse_pos = Engine::Input.mouse_pos
    return set_brightness(DIM_MULTIPLIER) unless mouse_pos

    world_pos = screen_to_world(mouse_pos)
    dist = Math.sqrt(
      (world_pos[0] - game_object.pos[0]) ** 2 +
      (world_pos[1] - game_object.pos[1]) ** 2
    )

    set_brightness(dist < HOVER_RADIUS ? LIT_MULTIPLIER : DIM_MULTIPLIER)
  end

  private

  def set_brightness(multiplier)
    @material.set_vec3("colour", @colour * multiplier)
  end

  def screen_to_world(mouse_pos)
    screen_w = Engine::Window.width
    screen_h = Engine::Window.height

    cam = Engine::Camera.instance
    half_w = cam.instance_variable_get(:@width) / 2.0
    half_h = cam.instance_variable_get(:@height) / 2.0

    x = (mouse_pos[0] / screen_w) * 2.0 * half_w - half_w
    y = ((screen_h - mouse_pos[1]) / screen_h) * 2.0 * half_h - half_h

    Vector[x, y, 0]
  end
end
