# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users
  resources :articles, only: %i[index show]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
