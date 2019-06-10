# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/treasure/loot'
require_relative '../../lib/dices/d100'
require_relative '../../lib/dices/d6'
require_relative '../../lib/coin'

RSpec.describe Treasure::Loot do
  describe '#initialize' do
    it 'initializes' do
      described_class.new(
        tier: Treasure::Loot::Tiers::LOW,
        type: Treasure::Loot::Types::INDIVIDUAL,
      )
    end
  end

  describe '#coins' do
    let(:d100) { instance_double(Dices::D100) }
    let(:d6) { instance_double(Dices::D6) }
    let(:dependencies) { { d100: d100, d6: d6 } }

    context 'individual treasures' do
      it 'generates coin loot for encounter tier and type' do
        allow(d100).to receive(:roll).and_return(1)
        allow(d6).to receive(:roll).and_return(5)

        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::INDIVIDUAL,
          dependencies: dependencies,
        )

        expect(loot.coins[0]).to have_attributes(
          type: Coin::Types::CP,
          ammount: 500,
        )

        expect(loot.coins[1]).to have_attributes(
          type: Coin::Types::EP,
          ammount: 50,
        )
      end
    end

    context 'horde treasures' do
      it 'generates loot for encounter tier and type' do
        allow(d6).to receive(:roll).and_return(6)

        loot = described_class.new(
          tier: Treasure::Loot::Tiers::MEDIUM,
          type: Treasure::Loot::Types::HORDE,
          dependencies: dependencies,
        )

        expect(loot.coins[0]).to have_attributes(
          type: Coin::Types::CP,
          ammount: 600,
        )

        expect(loot.coins[1]).to have_attributes(
          type: Coin::Types::SP,
          ammount: 6000,
        )

        expect(loot.coins[2]).to have_attributes(
          type: Coin::Types::GP,
          ammount: 600,
        )

        expect(loot.coins[3]).to have_attributes(
          type: Coin::Types::PP,
          ammount: 60,
        )
      end
    end
  end
end
