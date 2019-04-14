# frozen_string_literal: true

require 'wild_dice'

module Dices
  class D6
    def initialize(number_of_dices: 1, dependencies: {})
      @dice = dependencies.fetch(:dice) do
        ::Wild::D6.new(multiplier: number_of_dices)
      end
    end

    def roll
      @dice.roll
    end
  end
end
