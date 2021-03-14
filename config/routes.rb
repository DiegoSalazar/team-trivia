# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'

  resources :team_messages, only: %i[index create]
  resources :joins
  resources :players
  resources :guesses, only: :index
  resources :teams do
    resources :players, only: :index do
      resource :joins, only: :create
    end
    resources :trivia, only: [] do
      member do
        get :play
      end
    end
  end
  resources :trivia, except: :show do
    member do
      get :reveal
      # get :add_question
      # post :create_question
      # post :delete_question
      resources :questions
    end
  end

  devise_for :player, controllers: { sessions: 'player/sessions' }
end
