# frozen_string_literal: true

require_relative '../lib/title_generator'
require_relative '../lib/dices/d6'

RSpec.describe TitleGenerator do
  it 'initializes without dependencies' do
    described_class.new
  end

  describe '#random_title' do
    let(:d6) { instance_double(Dices::D6, roll: 3) }
    let(:dependencies) { { d6: d6 } }

    it 'returns a random title' do
      title = described_class.new(dependencies).random_title
      expect(title).to eq('Hypeebonic Loot Chamber')
    end
  end
end
