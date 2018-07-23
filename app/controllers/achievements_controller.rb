# frozen_string_literal: true

class AchievementsController < ApplicationController
  before_action :permission?

  def new
    @achievement = Achievement.new
  end

  def edit
    achievement
  end

  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      redirect_to root_path, notice: t('actions.success.create', resource: achievement_locale)
    else
      render :new
    end
  end

  def update
    if achievement.update(achievement_params)
      redirect_to root_path, notice: t('actions.success.update', resource: achievement_locale)
    else
      render :edit
    end
  end

  def destroy
    achievement.destroy
    redirect_to root_path, notice: t('actions.success.destroy', resource: achievement_locale)
  end

  private

  def permission?
    redirect_to root_path unless current_user.teacher?
  end

  def achievement_locale
    t('activerecord.models.achievement.one')
  end

  def achievement
    @achievement = Achievement.find(params[:id])
  end

  def achievement_params
    params.require(:achievement).permit(:lesson_id, :user_id, :points, :attendance, :kind)
  end
end
