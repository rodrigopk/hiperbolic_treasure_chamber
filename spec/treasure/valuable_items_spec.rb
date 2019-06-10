# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/treasure/valuable_items'
require_relative '../../lib/treasure/loot'
require_relative '../../lib/dices/d100'
require_relative '../../lib/dices/d6'

RSpec.describe Treasure::ValuableItems do
  let(:d100) { instance_double(Dices::D100) }
  let(:d6) { instance_double(Dices::D6) }
  let(:dependencies) { { d100: d100, d6: d6 } }

  it 'initializes without dependencies' do
    described_class.new(encounter_tier: Treasure::Loot::Tiers::LOW)
  end

  describe '#gems' do
    it 'exposes the rolled gems' do
      allow(d100).to receive(:roll).and_return(10)
      allow(d6).to receive(:roll).and_return(6)

      items = described_class.new(
        encounter_tier: Treasure::Loot::Tiers::LOW,
        dependencies: dependencies,
      )

      expect(items.gems).to have_attributes(
        ammount: 6,
        type: ValuableItem::Types::GEMS,
      )
    end

    context 'no valuable items rolled' do
      it 'returns nil' do
        allow(d100).to receive(:roll).and_return(0)

        items = described_class.new(
          encounter_tier: Treasure::Loot::Tiers::LOW,
          dependencies: dependencies,
        )

        expect(items.gems).to be_nil
      end
    end
  end

  describe '#art_objects' do
    it 'exposes the rolled gems' do
      allow(d100).to receive(:roll).and_return(20)
      allow(d6).to receive(:roll).and_return(6)

      items = described_class.new(
        encounter_tier: Treasure::Loot::Tiers::LOW,
        dependencies: dependencies,
      )

      expect(items.art_objects).to have_attributes(
        ammount: 6,
        type: ValuableItem::Types::ART_OBJECTS,
      )
    end

    context 'no valuable items rolled' do
      it 'returns nil' do
        allow(d100).to receive(:roll).and_return(0)

        items = described_class.new(
          encounter_tier: Treasure::Loot::Tiers::LOW,
          dependencies: dependencies,
        )

        expect(items.art_objects).to be_nil
      end
    end
  end
end
