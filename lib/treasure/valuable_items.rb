# frozen_string_literal: true

require 'yaml'

require_relative '../dices/d100'
require_relative '../dices/d6'
require_relative '../valuable_item'

module Treasure
  class ValuableItems
    attr_reader :gems, :art_objects

    def initialize(encounter_tier:, dependencies: {})
      @dependencies = dependencies
      @items_yaml = YAML.load_file(
        "lib/treasure/config/valuable_items/horde/#{encounter_tier}.yml",
      )

      roll_gems_and_artwork_for_tier(encounter_tier)
    end

    private

    def roll_gems_and_artwork_for_tier(tier)
      table_roll = d100.roll

      @gems = gems_for_tier_and_table_roll(tier, table_roll)
      @art_objects = art_objects_for_tier_and_table_roll(tier, table_roll)
    end

    def gems_for_tier_and_table_roll(tier, table_roll)
      valuable_object_for_type_and_attributes(
        ValuableItem::Types::GEMS,
        attributes_for_tier_and_roll(tier, table_roll)['gems'],
      )
    end

    def art_objects_for_tier_and_table_roll(tier, table_roll)
      valuable_object_for_type_and_attributes(
        ValuableItem::Types::ART_OBJECTS,
        attributes_for_tier_and_roll(tier, table_roll)['art_objects'],
      )
    end

    def attributes_for_tier_and_roll(tier, roll)
      @items_yaml['valuable_items']['horde'][tier][roll]
    end

    def valuable_object_for_type_and_attributes(type, attributes)
      return nil if attributes.nil?

      ValuableItem.new(
        type: type,
        ammount: d6(attributes['dices']).roll,
        value_tier: attributes['value_tier'],
      )
    end

    def d6(dice_number)
      @dependencies.fetch(:d6) do
        Dices::D6.new(number_of_dices: dice_number)
      end
    end

    def d100
      @d100 = @dependencies.fetch(:d100) do
        Dices::D100.new
      end
    end
  end
end
