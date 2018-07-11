# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    redirect_to root_path unless current_user
    redirect_to group_path(current_user.group_id) if current_user&.student?
    @groups = Group.all
  end

  def show
    redirect_to root_path unless id == current_user.group_id || !current_user.student?
    @group = Group.find id
  end

  private

  def id
    @id = params[:id].to_i
  end
end
