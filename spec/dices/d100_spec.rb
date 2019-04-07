# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/dices/d100'

RSpec.describe Dices::D100 do
  describe '#initialize' do
    it 'initializes correctly' do
      described_class.new
    end
  end

  describe '#roll' do
    let(:dice) { instance_double(Wild::Dice) }

    it 'rolls a number between 0 and 99' do
      allow(dice).to receive(:roll).and_return('50')

      d100 = described_class.new(dice: dice)

      expect(d100.roll).to eq(50)
    end
  end
end
