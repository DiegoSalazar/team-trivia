# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'

  resources :joins
  resources :players
  resources :answers
  resources :questions
  resources :guesses do
    post :vote
  end
  resources :submissions do
    post :add_guess
  end
  resources :teams
  resources :trivia do
    resources :teams, only: [] do
      resource :submission, only: [:edit]
    end
  end
  resources :question_templates do
    get :add_answer
    resources :answer_templates
  end
end
