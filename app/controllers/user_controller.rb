# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # magic here
  end
end
