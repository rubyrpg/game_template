class BobAndSpin < Engine::Component
  SPIN_SPEED = 120
  BOB_SPEED = 2
  BOB_HEIGHT = 0.15

  def start
    @start_y = game_object.pos[1]
    @time = 0
  end

  def update(delta_time)
    @time += delta_time

    game_object.rotation *= Engine::Quaternion.from_euler(Vector[0, SPIN_SPEED * delta_time, 0])
    game_object.pos[1] = @start_y + Math.sin(@time * BOB_SPEED) * BOB_HEIGHT
  end
end
