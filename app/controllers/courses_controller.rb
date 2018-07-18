# frozen_string_literal: true

class CoursesController < ApplicationController
  def show
    @course = Course.includes('group', 'subject', 'user').find(params[:id])
    redirect_to root_path if redirect?
  end

  private

  def redirect?
    !@course.displayed || @course.student_access_forbidden?(current_user)
  end
end
