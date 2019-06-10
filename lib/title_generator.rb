# frozen_string_literal: true

require_relative './dices/d6'

class TitleGenerator
  TITLES = {
    1 => 'Hypeebolah Loot Chamber',
    2 => 'Hyperglycemic Loot Chamber',
    3 => 'Hypeebonic Loot Chamber',
    4 => 'Hypertonic Loot Tamer',
    5 => 'Hypersonic Loot Tamer',
    6 => 'Hyperbolic Loot Chamber'
  }.freeze

  def initialize(dependencies = {})
    @d6 = dependencies.fetch(:d6) do
      Dices::D6.new
    end
  end

  def random_title
    TITLES[@d6.roll]
  end
end
