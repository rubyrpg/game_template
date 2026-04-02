class WrapAround < Engine::Component
  def update(delta_time)
    if game_object.x > Engine::Window.framebuffer_width
      game_object.x = 0
    elsif game_object.x < 0
      game_object.x = Engine::Window.framebuffer_width
    end

    if game_object.y > Engine::Window.framebuffer_height
      game_object.y = 0
    elsif game_object.y < 0
      game_object.y = Engine::Window.framebuffer_height
    end
  end
end
