# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'

  resources :joins
  resources :players
  resources :answers
  resources :questions
  resources :guesses
  resources :submissions
  resources :plays
  resources :teams
  resources :trivia
end
