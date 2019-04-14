# frozen_string_literal: true

Rails.application.routes.draw do
  post '/', to: 'loot#generate', as: 'generate'

  root 'loot#new'
end
