# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/treasure/coins'

RSpec.describe Treasure::Coin do
  describe '#initialize' do
    it 'initializes correctly' do
      described_class.new(
        type: Treasure::Coin::Types::GP,
        ammount: 100,
      )
    end
  end

  describe '#type' do
    it 'can be read' do
      type = Treasure::Coin::Types::GP
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
        type: Treasure::Coin::Types::GP,
        ammount: ammount,
      )

      expect(coin.ammount).to eq(ammount)
    end
  end
end
