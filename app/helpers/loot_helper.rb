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
      ['Low (CR 0-4)', Treasure::Loot::Tiers::LOW],
      ['Medium  (CR 5-10)', Treasure::Loot::Tiers::MEDIUM],
      ['High (CR 11-16)', Treasure::Loot::Tiers::HIGH],
      ['Legendary  (CR 17+)', Treasure::Loot::Tiers::LEGENDARY]
    ]
  end

  def art_objects_in_loot?
    @loot.art_objects.present?
  end

  def gems_in_loot?
    @loot.gems.present?
  end
end
