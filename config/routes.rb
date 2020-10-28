# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'
  
  resources :teams
  resources :trivia
end
