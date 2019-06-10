# frozen_string_literal: true

require 'yaml'

require_relative './dices/d10'
require_relative './coin'

class ValuableItem
  attr_reader :type, :ammount, :description, :value_in_coins

  DESCRIPTION_YAML_CONFIG = 'lib/treasure/config/valuable_item.yml'

  VALUES_FOR_TYPE_AND_TIER = {
    'art_objects' => {
      1 => 25,
      2 => 250,
      3 => 750,
      4 => 2500,
      5 => 7500
    },
    'gems' => {
      1 => 10,
      2 => 50,
      3 => 500,
      4 => 1000,
      5 => 5000
    }
  }.freeze

  class Types
    NONE = 'none'
    GEMS = 'gems'
    ART_OBJECTS = 'art_objects'
  end

  def initialize(type:, ammount:, value_tier:, dependencies: {})
    @d10 = dependencies.fetch(:d10) do
      Dices::D10.new
    end

    @type = type
    @ammount = ammount_from_type(ammount, type)
    @description = description_from_type_and_value_tier(type, value_tier)
    @value_in_coins = value_in_coins_for_type_and_value_tier(type, value_tier)
  end

  private

  def ammount_from_type(ammount, type)
    return 0 if type == Types::NONE
    ammount
  end

  def description_from_type_and_value_tier(type, value_tier)
    return '' if type == Types::NONE

    roll_for_type_and_tier(type, value_tier)
  end

  def roll_for_type_and_tier(type, tier)
    descriptions_from_type_and_tier(type, tier)[@d10.roll]
  end

  def descriptions_from_type_and_tier(type, tier)
    description_yaml['valuable_item'][type]['value_tiers'][tier]['descriptions']
  end

  def description_yaml
    YAML.load_file(DESCRIPTION_YAML_CONFIG)
  end

  def value_in_coins_for_type_and_value_tier(type, value_tier)
    return nil if type == Types::NONE

    Coin.new(
      type: Coin::Types::GP,
      ammount: VALUES_FOR_TYPE_AND_TIER[type][value_tier],
    )
  end
end
