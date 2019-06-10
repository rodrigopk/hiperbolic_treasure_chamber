# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/treasure/loot'
require_relative '../../lib/treasure/coins'
require_relative '../../lib/treasure/valuable_items'
require_relative '../../lib/coin'

RSpec.describe Treasure::Loot do
  let(:coins_treasure) { instance_double(Treasure::Coins, coins: coins) }
  let(:valuable_items_treasure) do
    instance_double(
      Treasure::ValuableItems,
      gems: gems,
      art_objects: art_objects,
    )
  end

  let(:dependencies) do
    {
      coins_treasure: coins_treasure,
      valuable_items_treasure: valuable_items_treasure
    }
  end

  let(:coins) { [instance_double(Coin)] }
  let(:gems) { instance_double(ValuableItem) }
  let(:art_objects) { instance_double(ValuableItem) }

  describe '#initialize' do
    context 'individual' do
      it 'initializes without dependencies' do
        described_class.new(
          tier: Treasure::Loot::Tiers::LOW,
          type: Treasure::Loot::Types::INDIVIDUAL,
        )
      end
    end

    context 'individual' do
      it 'initializes without dependencies' do
        described_class.new(
          tier: Treasure::Loot::Tiers::LOW,
          type: Treasure::Loot::Types::HORDE,
        )
      end
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

  describe '#gems' do
    context 'individual treasures' do
      it 'returns nil' do
        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::INDIVIDUAL,
          dependencies: dependencies,
        )

        expect(loot.gems).to be_nil
      end
    end

    context 'horde treasures' do
      it 'generates the gems treasure' do
        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::HORDE,
          dependencies: dependencies,
        )

        expect(loot.gems).to eq(gems)
      end
    end
  end

  describe '#art_objects' do
    context 'individual treasures' do
      it 'returns nil' do
        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::INDIVIDUAL,
          dependencies: dependencies,
        )

        expect(loot.art_objects).to be_nil
      end
    end

    context 'horde treasures' do
      it 'generates the gems treasure' do
        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::HORDE,
          dependencies: dependencies,
        )

        expect(loot.art_objects).to eq(art_objects)
      end
    end
  end
end
