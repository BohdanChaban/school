# frozen_string_literal: true

class CoursesController < ApplicationController
  def index
    if current_user.student?
      @courses = current_user.group.courses.includes(:subject)
    elsif current_user.teacher?
      @courses = current_user.courses.includes(:group)
    else
      redirect_to root_path
    end
  end

  def show
    @course = Course.includes('group', 'subject', 'user').find(params[:id])
    @title = t('activerecord.models.course.one')
    redirect_to root_path if redirect?
  end

  private

  def redirect?
    !@course.displayed || @course.student_access_forbidden?(current_user)
  end
end
