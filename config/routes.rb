# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  resources :users, only: %i[index]

  root to: 'articles#index'
  resources :articles, only: %i[index show]

  resources :groups, only: %i[index show]

  resources :subjects, only: %i[index]

  resources :courses, only: %i[index show] do
    resources :themes, except: %i[index show] do
      resources :lessons, except: %i[index show]
    end
  end

  resources :hometasks

  resources :timeslots, only: %i[index]

  resources :achievements, except: %i[index show]
end
