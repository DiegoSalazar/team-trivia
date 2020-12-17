# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'

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
  resources :question_templates do
    get :add_answer
    resources :answer_templates
  end
end
