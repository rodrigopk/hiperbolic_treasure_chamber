# frozen_string_literal: true

module Treasure
  class Coin
    class Types
      CP = 'cp'
      EP = 'ep'
      SP = 'sp'
      GP = 'gp'
      PP = 'pp'
    end

    attr_reader :type, :ammount

    def initialize(type:, ammount:)
      @type = type
      @ammount = ammount
    end

    def to_s
      "#{ammount} #{type}"
    end
  end
end
