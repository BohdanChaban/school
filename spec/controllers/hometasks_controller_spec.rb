# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HometasksController, type: :controller do
  # Helpers definition
  let(:other_role) { FactoryBot.create(:valid_user_for_mentor_role) }

  let(:student) { FactoryBot.create(:valid_user_with_group) }
  let(:teacher) { course.user }
  let(:course) { hometask.lesson.theme.course }
  let(:hometask) { FactoryBot.create(:valid_hometask_with_all_optional) }

  describe 'GET #index' do
    render_views
    it 'returns http success if user is a student' do
      login_with student
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns http success if user is a teacher' do
      login_with teacher
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'redirects to root if user has other role' do
      login_with other_role
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end

    it 'renders teacher partial if user is a teacher' do
      login_with teacher
      get :index
      expect(response).to render_template :index
      expect(response).to render_template(partial: '_teacher')
    end

    it 'renders student partial if user is a student' do
      login_with student
      get :index
      expect(response).to render_template :index
      expect(response).to render_template(partial: '_student')
    end
  end

  describe 'GET #new' do
    render_views
    it 'render hometasks/new template with teacher role' do
      login_with teacher
      get :new
      expect(response).to render_template('hometasks/new')
    end
    it 'redirects to root if user is not a teacher' do
      login_with student
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #edit' do
    render_views
    it 'render hometasks/edit template with teacher role' do
      login_with teacher
      get :edit, params: { id: hometask.id }
      expect(response).to render_template('hometasks/edit')
    end
    it 'redirects to root if user is not a teacher' do
      login_with other_role
      get :edit, params: { id: hometask.id }
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST #create' do
    render_views
    it 'redirects to hometasks path if hometask has valid parameters' do
      login_with teacher
      post :create, params: { hometask: { description: 'valid_description', lesson_id: hometask.lesson_id } }
      expect(response).to redirect_to hometasks_path
    end
    it 'redirects to root if user is not a teacher' do
      login_with other_role
      get :create, params: { hometask: { description: 'valid_description', lesson_id: hometask.lesson_id } }
      expect(response).to redirect_to root_path
    end
    it 'render hometasks/new if hometask has invalid parameters' do
      login_with teacher
      post :create, params: { hometask: { description: 'va', lesson_id: hometask.lesson_id } }
      expect(response).to render_template('hometasks/new')
    end
  end

  describe 'PUT #update' do
    render_views
    it 'updates hometask with valid parameters' do
      login_with teacher
      put :update, params: { id: hometask.id, hometask: { description: 'new_description' } }
      expect(Hometask.find(hometask.id).description).to eq('new_description')
    end
    it 'does not update hometask with invalid parameters' do
      login_with teacher
      put :update, params: { id: hometask.id, hometask: { description: 'va' } }
      expect(Hometask.find(hometask.id).description).not_to eq('va')
    end
    it 'redirects to root if user is not a teacher' do
      login_with other_role
      put :update, params: { id: hometask.id, hometask: { description: 'new_description' } }
      expect(response).to redirect_to root_path
    end
  end

  describe 'DELETE #destroy' do
    render_views
    it 'updates hometask with valid parameters' do
      login_with teacher
      delete :destroy, params: { id: hometask.id }
      expect(response).to redirect_to hometasks_path
    end
    it 'redirects to root if user is not a teacher' do
      login_with other_role
      delete :destroy, params: { id: hometask.id }
      expect(response).to redirect_to root_path
    end
  end
end
