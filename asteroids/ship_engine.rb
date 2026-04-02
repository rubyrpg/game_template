# frozen_string_literal: true

class ShipEngine < Engine::Component
  ACCELERATION = 400
  DECELERATION = 400
  MAX_SPEED = 400
  TURNING_SPEED = 300

  def awake
    @velocity ||= Vector[0, 0, 0]
  end

  def update(delta_time)
    direction = game_object.up.normalize
    @velocity += direction * acceleration * delta_time
    clamp_speed
    game_object.pos += @velocity * delta_time

    game_object.rotation *= Engine::Quaternion.from_euler(Vector[0, 0, torque * delta_time])
  end

  private

  def acceleration
    return ACCELERATION if Engine::Input.key?(Engine::Input::KEY_UP) || Engine::Input.key?(Engine::Input::KEY_W)
    return -DECELERATION if Engine::Input.key?(Engine::Input::KEY_DOWN) || Engine::Input.key?(Engine::Input::KEY_S)

    0
  end

  def clamp_speed
    if @velocity.magnitude > MAX_SPEED
      @velocity = @velocity / @velocity.magnitude * MAX_SPEED
    end
  end

  def torque
    total_torque = 0
    total_torque -= TURNING_SPEED if Engine::Input.key?(Engine::Input::KEY_LEFT) || Engine::Input.key?(Engine::Input::KEY_A)
    total_torque += TURNING_SPEED if Engine::Input.key?(Engine::Input::KEY_RIGHT) || Engine::Input.key?(Engine::Input::KEY_D)
    total_torque
  end
end
