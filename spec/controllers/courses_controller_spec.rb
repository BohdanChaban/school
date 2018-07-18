# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  # Helpers definition
  let(:other_student_email) { 'other_student@exmaple.com' }
  let(:other_group_number) { 6 }

  let(:student) { FactoryBot.create(:valid_user_with_group) }
  let(:teacher) { course.user }
  let(:other_student) { FactoryBot.create(:valid_user, email: other_student_email, group_id: other_group.id) }

  let(:course) { FactoryBot.create(:valid_course_with_displayed, group_id: student.group_id) }
  let(:other_group) { FactoryBot.create(:valid_group, number: other_group_number) }
  let(:course_without_displayed) { FactoryBot.create(:valid_course, group_id: student.group_id) }

  describe 'GET show' do
    it 'renders the show template with self student group id' do
      login_with student
      get :show, params: { id: course.id }
      expect(response).to render_template :show
    end

    it 'renders the show template with self teacher group id' do
      login_with teacher
      get :show, params: { id: course.id }
      expect(response).to render_template :show
    end

    it 'redirect to root path with not self student group id' do
      login_with other_student
      get :show, params: { id: course.id }
      expect(response).to redirect_to root_path
    end

    it 'redirect to root path without displayed course ' do
      login_with student
      get :show, params: { id: course_without_displayed.id }
      expect(response).to redirect_to root_path
    end
  end
end
