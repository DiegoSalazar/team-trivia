# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trivia#index'

  resources :team_messages, only: %i[index create]
  resources :players
  resources :teams do
    resources :trivia, only: [] do
      member do
        get :play
        get 'play/:question_id', action: :play, as: :play_question
      end

      resources :guesses, only: [:show] do
        member do
          resources :votes, only: :create, as: :guess_votes
        end
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
