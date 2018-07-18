# frozen_string_literal: true

class CoursesController < ApplicationController
  def show
    @course = Course.includes('group', 'subject', 'user').find(params[:id])
    redirect_to root_path if redirect?
  end

  private

  def redirect?
    return true unless @course.displayed
    return true if current_user.student? && @course.group_id != current_user.group_id
    false
  end
end
