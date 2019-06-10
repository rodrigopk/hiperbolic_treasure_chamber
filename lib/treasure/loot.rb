# frozen_string_literal: true

require 'yaml'

require_relative '../dices/d100'
require_relative '../dices/d6'
require_relative './coins'

module Treasure
  class Loot
    attr_reader :coins

    class Tiers
      LOW = 'low'
      MEDIUM = 'medium'
      HIGH = 'high'
      LEGENDARY = 'legendary'
    end

    class Types
      INDIVIDUAL = 'individual'
      HORDE = 'horde'
    end

    def initialize(tier:, type:, dependencies: {})
      @tier = tier
      @type = type

      @coins_treasure = dependencies.fetch(:coins_treasure) do
        Treasure::Coins.new(tier: tier, type: type)
      end

      @coins = @coins_treasure.coins
    end
  end
end
