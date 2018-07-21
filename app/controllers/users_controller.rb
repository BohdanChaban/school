# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @teachers = User.teacher.includes(:subjects)
  end
end
