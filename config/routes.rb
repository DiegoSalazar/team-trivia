# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'
  devise_for :players

  resources :messages, only: :create
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
      resource :messages, only: :create
    end
    member do
      get :play
    end
  end
  resources :trivia do
    member do
      get :add_question
      post :create_question
      post :delete_question
    end
    resources :teams, only: [] do
      resource :submission, only: [:edit, :show]
    end
  end
  resources :question_templates do
    get :add_answer
    resources :answer_templates
  end
end
