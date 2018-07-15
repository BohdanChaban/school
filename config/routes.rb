# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  root to: 'articles#index'
  devise_for :users
  resources :articles, only: %i[index show]
  resources :groups, only: %i[index show]
  resources :subjects, only: %i[index]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
