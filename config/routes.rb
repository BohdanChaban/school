# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#dashboard'

  devise_for :users
end
