# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThemesController, type: :controller do
  let(:not_valid_topic) { 'test' }
  let(:valid_topic) { "#{not_valid_topic} #{not_valid_topic}" }

  let(:student) { FactoryBot.create(:valid_user_with_group) }
  let(:teacher) { course.user }
  let(:group) { student.group }
  let(:course) { FactoryBot.create(:valid_course_with_displayed, group_id: student.group_id) }
  let(:theme) { FactoryBot.create(:valid_theme, course: course) }
  let(:params) { { use_route: "courses/#{course}/themes/", course_id: course.id } }

  describe 'GET new' do
    it 'redner themes/new template with teacher role' do
      login_with teacher
      get :new, params: { course_id: course.id }
      expect(response).to render_template('themes/new')
    end

    it 'redirect to root without teacher role' do
      login_with student
      get :new, params: { course_id: course.id }
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET edit' do
    it 'redner themes/edit template with teacher role' do
      login_with teacher
      get :edit, params: { course_id: course.id, id: theme.id }
      expect(response).to render_template('themes/edit')
    end

    it 'redirect to root without teacher role' do
      login_with student
      get :edit, params: { course_id: course.id, id: theme.id }
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST create' do
    it 'redirect to course after create theme with valid params' do
      login_with teacher
      post :create, params: { course_id: course.id, theme: { topic: valid_topic } }
      expect(response).to redirect_to course_path(id: course.id)
    end

    it 'redner themes/new template after create theme without valid params' do
      login_with teacher
      post :create, params: { course_id: course.id, theme: { topic: not_valid_topic } }
      expect(response).to render_template('themes/new')
    end

    it 'redirect to root without teacher role' do
      login_with student
      post :create, params: { course_id: course.id }
      expect(response).to redirect_to root_path
    end
  end

  describe 'PUT update' do
    it 'seccuss changed name after update theme with valid params' do
      login_with teacher
      put :update, params: { course_id: course.id, id: theme.id, theme: { topic: valid_topic } }
      expect(Theme.find(theme.id).topic).to eq(valid_topic)
    end

    it 'fail changed name after update theme without valid params' do
      login_with teacher
      put :update, params: { course_id: course.id, id: theme.id, theme: { topic: not_valid_topic } }
      expect(Theme.find(theme.id).topic).not_to eq(not_valid_topic)
    end

    it 'redirect to root without teacher role' do
      login_with student
      put :update, params: { course_id: course.id, id: theme.id }
      expect(response).to redirect_to root_path
    end
  end

  describe 'DELETE destroy' do
    it 'redirect to course after destroy theme' do
      login_with teacher
      delete :destroy, params: { course_id: course.id, id: theme.id }
      expect(response).to redirect_to course_path(id: course.id)
    end

    it 'redirect to root without teacher role' do
      login_with student
      delete :destroy, params: { course_id: course.id, id: theme.id }
      expect(response).to redirect_to root_path
    end
  end
end
