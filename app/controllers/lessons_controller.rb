# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :check_access
  def new
    @lesson = new_lesson_path.new
  end

  def create
    @lesson = new_lesson_path.new(lesson_params)
    if @lesson.save
      redirect_to course_path(id: course.id),
                  notice: t('actions.success.create',
                            resource: lesson_locale)
    else
      render :new
    end
  end

  def edit
    course
    theme
    lesson
  end

  def update
    if lesson.update(lesson_params)
      redirect_to course_path(id: course.id),
                  notice: t('actions.success.update',
                            resource: lesson_locale)
    else
      render :edit, course: course, theme: theme
    end
  end

  def destroy
    lesson.destroy
    redirect_to course_path(id: course.id),
                notice: t('actions.success.destroy',
                          resource: lesson_locale)
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def new_lesson_path
    course.themes.find(theme.id).lessons
  end

  def theme
    @theme ||= Theme.find(params[:theme_id])
  end

  def lesson
    @lesson ||= Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:topic, :description, :links, :date)
  end

  def lesson_locale
    t('activerecord.models.lesson.one')
  end

  def check_access
    redirect_to root_path unless current_user.teacher?
  end
end
