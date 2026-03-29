# frozen_string_literal: true

class CameraController < Engine::Component
  ROTATION_SPEED = 60
  MOVE_SPEED = 2
  MAX_PITCH = 89

  def start
    Engine::Cursor.disable
    @pitch = 0.0
    @yaw = 0.0
  end

  def update(delta_time)
    mouse_delta = Engine::Input.mouse_delta

    @yaw += mouse_delta[0] * ROTATION_SPEED * delta_time
    @pitch += mouse_delta[1] * ROTATION_SPEED * delta_time
    @pitch = @pitch.clamp(-MAX_PITCH, MAX_PITCH)

    game_object.rotation = Engine::Quaternion.from_euler(Vector[@pitch, @yaw, 0])

    speed = MOVE_SPEED
    speed *= 3 if Engine::Input.key?(Engine::Input::KEY_LEFT_SHIFT)

    if Engine::Input.key?(Engine::Input::KEY_A)
      game_object.pos -= game_object.right * speed * delta_time
    end
    if Engine::Input.key?(Engine::Input::KEY_D)
      game_object.pos += game_object.right * speed * delta_time
    end
    if Engine::Input.key?(Engine::Input::KEY_W)
      game_object.pos -= Vector[game_object.forward[0], 0, game_object.forward[2]].normalize * speed * delta_time
    end
    if Engine::Input.key?(Engine::Input::KEY_S)
      game_object.pos += Vector[game_object.forward[0], 0, game_object.forward[2]].normalize * speed * delta_time
    end
    if Engine::Input.key?(Engine::Input::KEY_Q)
      game_object.pos -= Vector[0, 1, 0] * speed * delta_time
    end
    if Engine::Input.key?(Engine::Input::KEY_E)
      game_object.pos += Vector[0, 1, 0] * speed * delta_time
    end
  end
end
