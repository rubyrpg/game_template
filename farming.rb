require "ruby_rpg"
require_relative "farming/walk_controller"
require_relative "farming/player"
require_relative "farming/scenery"

Engine.start do
  Engine::Cursor.disable

  Farming::Player.create
  Farming::Scenery.create
end
