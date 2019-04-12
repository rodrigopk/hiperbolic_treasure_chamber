# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/treasure/loot'
require_relative '../../lib/dices/d100'
require_relative '../../lib/dices/d6'
require_relative '../../lib/treasure/coins'

RSpec.describe Treasure::Loot do
  describe '#initialize' do
    it 'initializes' do
      described_class.new(tier: 'low', type: 'individual')
    end
  end

  describe '#coins' do
    let(:d100) { instance_double(Dices::D100) }
    let(:d6) { instance_double(Dices::D6) }
    let(:dependencies) { { d100: d100, d6: d6 } }

    it 'generates coin loot for encounter tier and type' do
      allow(d100).to receive(:roll).and_return(1)
      allow(d6).to receive(:roll).and_return(5)

      loot = described_class.new(
        tier: 'medium', type: 'individual', dependencies: dependencies,
      )

      expect(loot.coins[0]).to have_attributes(
        type: Treasure::Coin::Types::CP,
        ammount: 500,
      )

      expect(loot.coins[1]).to have_attributes(
        type: Treasure::Coin::Types::EP,
        ammount: 50,
      )
    end
  end
end
