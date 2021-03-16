# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'

  resources :team_messages, only: %i[index create]
  resources :players
  resources :guesses, only: :index
  resources :teams do
    resources :trivia, only: [] do
      member do
        get :play
      end
    end
  end
  resources :trivia, except: :show do
    member do
      get :reveal
    end
    resources :questions
  end

  get '/I/dont/need/a/team', to: 'no_team#index'
  get '/Im/a/badass', to: 'no_team#show'

  devise_for :player, controllers: { sessions: 'player/sessions' }
end
