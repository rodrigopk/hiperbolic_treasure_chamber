# frozen_string_literal: true

require_relative '../../lib/treasure/loot'

class LootController < ApplicationController
  def new
    @selected_tier = Treasure::Loot::Tiers::LOW
    @selected_type = Treasure::Loot::Types::INDIVIDUAL

    @loot = generate_loot_for_tier_and_type
  end

  def generate
    puts params
    @selected_tier = params[:tier]
    @selected_type = params[:type]

    @loot = generate_loot_for_tier_and_type
  end

  private

  def generate_loot_for_tier_and_type
    Treasure::Loot.new(tier: @selected_tier, type: @selected_type)
  end
end
