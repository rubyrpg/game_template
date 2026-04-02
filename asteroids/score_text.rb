# frozen_string_literal: true

module Asteroids
  module ScoreText
    def self.create
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
    end
  end
end
