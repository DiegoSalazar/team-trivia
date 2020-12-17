# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'
  devise_for :players

  resources :joins
  resources :players
  resources :answers
  resources :questions
  resources :guesses
  resources :submissions
  resources :teams
  resources :trivia do
    resources :teams, only: [] do
      resource :submission, only: [:show]
    end
  end
end
