# frozen_string_literal: true

require 'yaml'

require_relative '../dices/d100'
require_relative '../dices/d6'
require_relative '../coin'

module Treasure
  class Coins
    attr_reader :coins

    def initialize(tier:, type:, dependencies: {})
      @tier = tier
      @type = type
      @dependencies = dependencies

      coins_config = YAML.load_file(
        "lib/treasure/config/coins/#{type}/#{tier}.yml",
      )

      @coins = generate_coins_treasure(coins_config['coins'][type][tier])
    end

    private

    def generate_coins_treasure(coins_table)
      if @type == Treasure::Loot::Types::INDIVIDUAL
        generate_individual_treasure(coins_table)
      else
        coins_from_table_entry(coins_table)
      end
    end

    def generate_individual_treasure(coins_table)
      table_entry = coins_table[roll_table_item]
      coins_from_table_entry(table_entry)
    end

    def coins_from_table_entry(entry)
      entry.map do |type, coin_modifiers|
        Coin.new(
          type: type,
          ammount: calculate_ammount_from_modifiers(coin_modifiers),
        )
      end
    end

    def calculate_ammount_from_modifiers(modifiers)
      roll_ammount_of_coins(modifiers['dices']) * modifiers['multiplier']
    end

    def roll_table_item
      d100.roll
    end

    def d100
      @dependencies.fetch(:d100) do
        Dices::D100.new
      end
    end

    def roll_ammount_of_coins(dice_number)
      d6(dice_number).roll
    end

    def d6(dice_number)
      @dependencies.fetch(:d6) do
        Dices::D6.new(number_of_dices: dice_number)
      end
    end
  end
end
