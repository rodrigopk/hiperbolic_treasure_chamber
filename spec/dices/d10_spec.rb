# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/dices/d10'

RSpec.describe Dices::D10 do
  describe '#initialize' do
    it 'initializes correctly' do
      described_class.new
    end
  end

  describe '#roll' do
    let(:dice) { instance_double(Wild::Dice) }

    it 'rolls a number between 0 and 9' do
      allow(dice).to receive(:roll).and_return('5')

      d100 = described_class.new(dice: dice)

      expect(d100.roll).to eq(5)
    end
  end
end
