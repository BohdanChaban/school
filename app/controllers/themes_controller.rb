# frozen_string_literal: true

class ThemesController < ApplicationController
  before_action :permission?

  def new
    @theme = course.themes.new
  end

  def edit
    course
    theme
  end

  def create
    @theme = course.themes.new(theme_params)
    if @theme.save
      redirect_to course_path(id: course),
                  notice: t('actions.success.create', resource: theme_locale)
    else
      render :new
    end
  end

  def update
    if theme.update(theme_params)
      redirect_to course_path(id: course),
                  notice: t('actions.success.update', resource: theme_locale)
    else
      render :edit
    end
  end

  def destroy
    theme.destroy
    redirect_to course_path(id: course),
                notice: t('actions.success.destroy', resource: theme_locale)
  end

  private

  def permission?
    redirect_to root_path unless current_user.teacher?
  end

  def theme_locale
    t('activerecord.models.theme.one')
  end

  def course
    @course ||= Course.find(params[:course_id])
  end

  def theme
    @theme ||= Theme.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:topic, :description, :links)
  end
end
