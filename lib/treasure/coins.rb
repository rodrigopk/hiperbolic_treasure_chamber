# frozen_string_literal: true

module Treasure
  class Coin
    class Types
      CP = 'cp'
      SP = 'sp'
      GP = 'gp'
      PP = 'pp'
    end

    attr_reader :type, :ammount

    def initialize(type:, ammount:)
      @type = type
      @ammount = ammount
    end
  end
end
