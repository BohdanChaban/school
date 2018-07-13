# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    redirect_to group_path(current_user.group_id) if current_user.student?
    @groups = Group.all
  end

  def show
    @group = Group.find params[:id]
    redirect_to root_path if current_user.student? && @group.id != current_user.group_id
  end
end
