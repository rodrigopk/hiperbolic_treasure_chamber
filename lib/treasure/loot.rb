# frozen_string_literal: true

require 'yaml'

require_relative './coins'
require_relative './valuable_items'

module Treasure
  class Loot
    attr_reader :coins, :gems, :art_objects

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
      @dependencies = dependencies

      @coins = roll_coins_for_tier_and_type(tier, type)
      roll_valuable_items_for_tier(tier) if type == Types::HORDE
    end

    private

    def roll_coins_for_tier_and_type(tier, type)
      coins_treasure = @dependencies.fetch(:coins_treasure) do
        Treasure::Coins.new(tier: tier, type: type)
      end

      coins_treasure.coins
    end

    def roll_valuable_items_for_tier(tier)
      valuable_items_treasure = @dependencies.fetch(:valuable_items_treasure) do
        Treasure::ValuableItems.new(encounter_tier: tier)
      end

      @gems = valuable_items_treasure.gems
      @art_objects = valuable_items_treasure.art_objects
    end
  end
end
