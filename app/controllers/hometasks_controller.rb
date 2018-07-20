# frozen_string_literal: true

class HometasksController < ApplicationController
  ALLOWED_ROLES = %w[student teacher].freeze
  def index
    if ALLOWED_ROLES.include?(current_user.role)
      @hometasks = current_user.hometasks
    else
      redirect_to root_path
    end
  end
end
