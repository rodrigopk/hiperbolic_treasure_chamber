# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/dices/d6'

RSpec.describe Dices::D6 do
  describe '#initialize' do
    it 'initializes correctly' do
      described_class.new
    end

    it 'can be initialized with a multiplier' do
      described_class.new(number_of_dices: 3)
    end
  end

  describe '#roll' do
    let(:dice) { instance_double(Wild::D6) }

    it 'rolls a number between 1 and 6' do
      allow(dice).to receive(:roll).and_return(3)

      d6 = described_class.new(dependencies: { dice: dice })

      expect(d6.roll).to eq(3)
    end
  end
end
