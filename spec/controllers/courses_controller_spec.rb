# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:course) { FactoryBot.create(:valid_course_with_displayed) }
  let(:student) { course.group.users.first }
  let(:teacher) { course.user }
  let(:other_role) { FactoryBot.create(:valid_user_for_mentor_role) }

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

    it 'renders student partial if user is a teacher' do
      login_with student
      get :index
      expect(response).to render_template :index
      expect(response).to render_template(partial: '_student')
    end
  end
end
