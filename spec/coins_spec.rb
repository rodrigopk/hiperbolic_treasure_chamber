# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/coin'

RSpec.describe Coin do
  describe '#initialize' do
    it 'initializes correctly' do
      described_class.new(
        type: Coin::Types::GP,
        ammount: 100,
      )
    end
  end

  describe '#type' do
    it 'can be read' do
      type = Coin::Types::GP
      coin = described_class.new(
        type: type,
        ammount: 100,
      )

      expect(coin.type).to eq(type)
    end
  end

  describe '#ammount' do
    it 'can be read' do
      ammount = 100
      coin = described_class.new(
        type: Coin::Types::GP,
        ammount: ammount,
      )

      expect(coin.ammount).to eq(ammount)
    end
  end

  describe '#to_s' do
    it 'prints the coin type and ammount' do
      coin = described_class.new(
        type: Coin::Types::GP,
        ammount: 100,
      )

      expect(coin.to_s).to eq('100 gp')
    end
  end
end
