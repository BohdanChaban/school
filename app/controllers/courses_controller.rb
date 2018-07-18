# frozen_string_literal: true

class CoursesController < ApplicationController
  def show
    @course = Course.includes("group","subject","user").where(id: params[:id])[0]
    p @course
    redirect_to root_path if redirect?
  end

  private

  def redirect?
    return true unless @course.displayed
    return true if current_user.student? && @course.group_id != current_user.group_id
    false
  end
end
