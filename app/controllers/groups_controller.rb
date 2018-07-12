# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    redirect_to root_path unless current_user
    redirect_to group_path(current_user.group_id) if current_user&.student?
    @groups = Group.all
  end

  def show
    group_id = params[:id].to_i
    redirect_to root_path if current_user.student? && group_id != current_user.group_id
    @group = Group.find group_id
  end
end
