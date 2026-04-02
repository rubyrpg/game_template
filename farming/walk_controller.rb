class WalkController < Engine::Component
  ROTATION_SPEED = 60
  MOVE_SPEED = 2
  MAX_PITCH = 89

  MIN_X = -5.0
  MAX_X = 5.0
  MIN_Z = -5.0
  MAX_Z = 5.0

  def start
    Engine::Cursor.disable
    euler = game_object.rotation.to_euler
    @pitch = euler[0]
    @yaw = euler[1]
    @fixed_y = game_object.pos[1]
  end

  def update(delta_time)
    mouse_delta = Engine::Input.mouse_delta

    @yaw += mouse_delta[0] * ROTATION_SPEED * delta_time
    @pitch += mouse_delta[1] * ROTATION_SPEED * delta_time
    @pitch = @pitch.clamp(-MAX_PITCH, MAX_PITCH)

    game_object.rotation = Engine::Quaternion.from_euler(Vector[@pitch, @yaw, 0])

    speed = MOVE_SPEED
    speed *= 3 if Engine::Input.key?(Engine::Input::KEY_LEFT_SHIFT)

    move = Vector[0, 0, 0]

    if Engine::Input.key?(Engine::Input::KEY_A)
      move -= game_object.right
    end
    if Engine::Input.key?(Engine::Input::KEY_D)
      move += game_object.right
    end
    if Engine::Input.key?(Engine::Input::KEY_W)
      fwd = Vector[game_object.forward[0], 0, game_object.forward[2]].normalize
      move -= fwd
    end
    if Engine::Input.key?(Engine::Input::KEY_S)
      fwd = Vector[game_object.forward[0], 0, game_object.forward[2]].normalize
      move += fwd
    end

    new_pos = game_object.pos + move * speed * delta_time
    new_pos = Vector[
      new_pos[0].clamp(MIN_X, MAX_X),
      @fixed_y,
      new_pos[2].clamp(MIN_Z, MAX_Z)
    ]
    game_object.pos = new_pos
  end
end
