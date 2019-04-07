# frozen_string_literal: true

require 'wild_dice'

module Dices
  class D6
    def initialize(multiplier: 1, dependencies: {})
      @multiplier = multiplier

      @dice = dependencies.fetch(:dice) do
        ::Wild::D6.new(multiplier: multiplier)
      end
    end

    def roll
      @dice.roll
    end
  end
end
