# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  root to: 'articles#index'
  devise_for :users
  resources :articles, only: %i[index show]
  resources :groups, only: %i[index show]
  resources :subjects, only: %i[index]
  resources :courses, only: %i[index show]
  resources :users, only: %i[index]
  resources :hometasks
  resources :timeslots, only: %i[index]
  resources :themes, except: %i[index show]
  resources :achievements, except: %i[index show]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
