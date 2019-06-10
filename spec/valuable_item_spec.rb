# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/dices/d10'
require_relative '../lib/valuable_item'
require_relative '../lib/coin'

RSpec.describe ValuableItem do
  let(:d10) { instance_double(Dices::D10, roll: 1) }

  describe '#initialize' do
    it 'initializes correctly' do
      described_class.new(
        type: ValuableItem::Types::GEMS,
        ammount: 2,
        value_tier: 1,
      )
    end
  end

  describe '#type' do
    context 'gems' do
      it 'returns the correct type' do
        type = ValuableItem::Types::GEMS

        item = create_item(type: type)

        expect(type).to eq(item.type)
      end
    end

    context 'art_objects' do
      it 'returns the correct type' do
        type = ValuableItem::Types::ART_OBJECTS

        item = create_item(type: type)

        expect(type).to eq(item.type)
      end
    end

    context 'none' do
      it 'returns the correct type' do
        type = ValuableItem::Types::NONE

        item = create_item(type: type)

        expect(type).to eq(item.type)
      end
    end
  end

  describe '#ammount' do
    it 'returns the correct ammount' do
      ammount = 2

      item = create_item(
        type: ValuableItem::Types::ART_OBJECTS,
        ammount: ammount,
      )

      expect(ammount).to eq(item.ammount)
    end

    context 'none' do
      it 'returns 0' do
        item = create_item(type: ValuableItem::Types::NONE)

        expect(item.ammount).to be_zero
      end
    end
  end

  describe '#description' do
    context '#gems' do
      it 'returns the correct description' do
        item = create_item

        expect(item.description).to eq('Azurite (opaque mottled deep blue)')
      end
    end

    context '#art_objects' do
      it 'returns the correct description' do
        item = create_item(type: ValuableItem::Types::ART_OBJECTS)

        expect(item.description).to eq('Silver ewer')
      end
    end

    context '#none' do
      it 'returns an empty description' do
        item = create_item(type: ValuableItem::Types::NONE)

        expect(item.description).to eq('')
      end
    end
  end

  describe '#value_in_coins' do
    context '#none' do
      it 'returns nil' do
        item = create_item(type: ValuableItem::Types::NONE)

        expect(item.value_in_coins).to be_nil
      end
    end

    context '#gems' do
      it 'returns the value in coins for the value tier' do
        item = create_item(value_tier: 3)

        expect(item.value_in_coins).to have_attributes(
          type: Coin::Types::GP,
          ammount: 500,
        )
      end
    end

    context '#art_objects' do
      it 'returns the value in coins for the value tier' do
        item = create_item(
          value_tier: 3,
          type: ValuableItem::Types::ART_OBJECTS,
        )

        expect(item.value_in_coins).to have_attributes(
          type: Coin::Types::GP,
          ammount: 750,
        )
      end
    end
  end

  describe '#to_s' do
    context 'gems' do
      it 'returns the correct formatted value' do
        item = create_item

        expect(item.to_s).to eq(
          "#{item.ammount}x #{item.value_in_coins} gems [#{item.description}]",
        )
      end
    end

    context 'art_objects' do
      it 'returns the correct formatted value' do
        item = create_item(type: ValuableItem::Types::ART_OBJECTS)

        expect(item.to_s).to eq(
          "#{item.ammount}x #{item.value_in_coins} art objects [#{item.description}]",
        )
      end
    end

    context 'none' do
      it 'returns an empty string' do
        item = create_item(type: ValuableItem::Types::NONE)

        expect(item.to_s).to eq('')
      end
    end
  end

  private

  def create_item(attr = {})
    described_class.new(
      {
        type: ValuableItem::Types::GEMS,
        ammount: 2,
        value_tier: 1,
        dependencies: { d10: d10 }
      }.merge(attr),
    )
  end
end
