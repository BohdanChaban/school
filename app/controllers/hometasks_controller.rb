# frozen_string_literal: true

class HometasksController < ApplicationController
  before_action :check_access, except: %i[index]
  before_action :set_hometask, only: %i[edit update destroy]

  ALLOWED_ROLES = %w[student teacher].freeze

  def index
    if ALLOWED_ROLES.include?(current_user.role)
      @hometasks = current_user.hometasks(:collect_last)
    else
      redirect_to root_path
    end
  end

  def new
    @hometask = Hometask.new
  end

  def create
    @hometask = Hometask.new(hometask_params)
    if @hometask.save
      redirect_to hometasks_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @hometask.update(hometask_params)
      redirect_to hometasks_path
    else
      render :edit
    end
  end

  def destroy
    @hometask.destroy
    redirect_to hometasks_path
  end

  private

  def set_hometask
    @hometask = Hometask.find(params[:id])
  end

  def hometask_params
    params.require(:hometask).permit(:description, :link, :lesson_id)
  end

  def check_access
    redirect_to root_path unless current_user.teacher?
  end
end
