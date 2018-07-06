# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "user#dashboard"

  devise_for :users

end
