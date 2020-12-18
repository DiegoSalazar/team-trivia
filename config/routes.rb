# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'
  devise_for :players

  resources :joins
  resources :players
  resources :answers
  resources :questions
  resources :submissions do
    post :add_guess
  end
  resources :teams
  resources :trivia do
    member do
      get :add_question
      post :create_question
      post :delete_question
    end
    resources :teams, only: [] do
      resource :submission, only: [:edit]
    end
  end
  resources :question_templates do
    get :add_answer
    resources :answer_templates
  end
end
