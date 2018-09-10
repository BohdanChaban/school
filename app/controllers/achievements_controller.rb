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
      update_thematic_achievements
      redirect_to edit_course_theme_lesson_url(lesson_params),
                  notice: t('actions.success.create', resource: achievement_locale)
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

  def lesson_params
    lesson = Lesson.find(achievement_params[:lesson_id])
    { id: lesson.id, course_id: lesson.theme.course_id, theme_id: lesson.theme_id }
  end

  def achievement_params
    params.require(:achievement).permit(:lesson_id, :user_id, :points, :attendance, :kind)
  end

  def update_thematic_achievements
    theme = @achievement.lesson.theme
    return unless theme_achievements(theme)

    achievement = Achievement.thematic.find_or_initialize_by(user: @achievement.user, theme: theme)
    achievement.update(points: average_achievement)
  end

  def theme_achievements(theme)
    @theme_achievements ||= Achievement.normal.where(user: @achievement.user, lesson: theme.lessons)
  end

  def average_achievement
    (@theme_achievements.sum(:points).to_f / @theme_achievements.count).round
  end
end
