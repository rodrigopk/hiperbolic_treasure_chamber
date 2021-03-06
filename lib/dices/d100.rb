# frozen_string_literal: true

require 'wild_dice'

module Dices
  class D100
    def initialize(dependencies = {})
      @dice = dependencies.fetch(:dice) do
        ::Wild::Dice.new(2)
      end
    end

    def roll
      @dice.roll.to_i
    end
  end
end
