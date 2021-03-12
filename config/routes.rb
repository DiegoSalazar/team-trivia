# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'

  resources :team_messages, only: %i[index create]
  resources :contributions, only: :new
  resources :joins
  resources :players
  resources :answers
  resources :questions
  resources :guesses
  resources :submissions do
    post :add_guess
  end
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
  resources :trivia do
    member do
      get :reveal
      get :add_question
      post :create_question
      post :delete_question
    end
    resources :teams, only: [] do
      resource :submission, only: [:edit, :show]
    end
  end
  resources :questions do
    get :add_answer
    resources :answer_templates
  end

  devise_for :player, controllers: { sessions: 'player/sessions' }
end
