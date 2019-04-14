# frozen_string_literal: true

require_relative '../../lib/treasure/loot'

module LootHelper
  def available_types
    [
      ['Individual', Treasure::Loot::Types::INDIVIDUAL],
      ['Horde', Treasure::Loot::Types::HORDE]
    ]
  end

  def available_tiers
    [
      ['Low', Treasure::Loot::Tiers::LOW],
      ['Medium', Treasure::Loot::Tiers::MEDIUM],
      ['High', Treasure::Loot::Tiers::HIGH],
      ['Legendary', Treasure::Loot::Tiers::LEGENDARY]
    ]
  end
end
