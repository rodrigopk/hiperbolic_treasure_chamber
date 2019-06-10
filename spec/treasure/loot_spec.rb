# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/treasure/loot'
require_relative '../../lib/treasure/coins'
require_relative '../../lib/coin'

RSpec.describe Treasure::Loot do
  let(:coins_treasure) { instance_double(Treasure::Coins, coins: coins) }
  let(:dependencies) { { coins_treasure: coins_treasure } }

  let(:coins) { [instance_double(Coin)] }

  describe '#initialize' do
    it 'initializes' do
      described_class.new(
        tier: Treasure::Loot::Tiers::LOW,
        type: Treasure::Loot::Types::INDIVIDUAL,
      )
    end
  end

  describe '#coins' do
    context 'individual treasures' do
      it 'generates coin loot for encounter tier and type' do
        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::INDIVIDUAL,
          dependencies: dependencies,
        )

        expect(loot.coins).to eq(coins)
      end
    end

    context 'horde treasures' do
      it 'generates loot for encounter tier and type' do
        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::HORDE,
          dependencies: dependencies,
        )

        expect(loot.coins).to eq(coins)
      end
    end
  end
end
