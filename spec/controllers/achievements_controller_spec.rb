# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AchievementsController, type: :controller do
  let(:valid_point) { 12 }
  let(:valid_kind) { 'normal' }
  let(:not_valid_point) { 43 }

  let(:student) { FactoryBot.create(:valid_user_with_group) }
  let(:course) { FactoryBot.create(:valid_course_with_displayed, group_id: student.group_id) }
  let(:teacher) { course.user }
  let(:lesson) { FactoryBot.create(:valid_lesson, theme: FactoryBot.create(:valid_theme, course: course)) }
  let(:achievement) { FactoryBot.create(:valid_achievement, user: student, lesson: lesson) }

  describe 'GET new' do
    it 'redner achievements/new template with teacher role' do
      login_with teacher
      get :new
      expect(response).to render_template('achievements/new')
    end

    it 'redirect to root without teacher role' do
      login_with student
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET edit' do
    it 'redner achievements/edit template with teacher role' do
      login_with teacher
      get :edit, params: { id: achievement.id }
      expect(response).to render_template('achievements/edit')
    end

    it 'redirect to root without teacher role' do
      login_with student
      get :edit, params: { id: achievement.id }
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST create' do
    it ' seccuss notice after create achievement with valid params' do
      login_with teacher
      achievement_params = {
        lesson_id: lesson.id,
        user_id: student.id,
        points: valid_point,
        attendance: true,
        kind: valid_kind
      }
      post :create, params: { achievement: achievement_params }
      expect(controller.notice).to eq('Achievement was successfully created.')
    end

    it 'redner achievements/new template after create achievement without valid params' do
      login_with teacher
      post :create, params: { achievement: { points: valid_point } }
      expect(response).to render_template('achievements/new')
    end

    it 'redirect to root without teacher role' do
      login_with student
      post :create
      expect(response).to redirect_to root_path
    end
  end

  describe 'PUT update' do
    it 'seccuss changed points after update achievement with valid params' do
      login_with teacher
      put :update, params: { id: achievement.id, achievement: { points: valid_point } }
      expect(Achievement.find(achievement.id).points).to eq(valid_point)
    end

    it 'render achievements/edit after update achievement without valid params' do
      login_with teacher
      put :update, params: { id: achievement.id, achievement: { points: not_valid_point } }
      expect(response).to render_template('achievements/edit')
    end

    it 'redirect to root without teacher role' do
      login_with student
      put :update, params: { id: achievement.id }
      expect(response).to redirect_to root_path
    end
  end

  describe 'DELETE destroy' do
    it 'redirect to course after destroy achievement' do
      login_with teacher
      delete :destroy, params: { id: achievement.id }
      expect(response).to redirect_to root_path
    end

    it 'redirect to root without teacher role' do
      login_with student
      delete :destroy, params: { id: achievement.id }
      expect(response).to redirect_to root_path
    end
  end
end
