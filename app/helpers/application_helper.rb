# frozen_string_literal: true

module ApplicationHelper
  PROJECT_GITHUB_URL = 'https://github.com/rodrigopk/hiperbolic_treasure_chamber'
  DUNGEONMASTERTOOLS_URL = 'https://dungeonmastertools.github.io'

  def github_url
    PROJECT_GITHUB_URL
  end

  def dm_toos_url
    DUNGEONMASTERTOOLS_URL
  end
end
