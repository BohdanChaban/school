# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeslotsController, type: :controller do
  let(:timeslot) { FactoryBot.create(:valid_timeslot) }
  let(:student) { FactoryBot.create(:valid_user_for_registration, group_id: timeslot.group_id) }
  let(:teacher) { student.group.courses.first.user }
  let(:teacher_without_course) { FactoryBot.create(:valid_user_for_teacher_role) }
  let(:mentor) { FactoryBot.create(:valid_user_for_mentor_role) }

  it 'returns http success if user is a student' do
    login_with student
    get :index
    expect(response).to have_http_status(:success)
  end

  it 'returns http success if user is a teacher with course' do
    login_with teacher
    get :index
    expect(response).to have_http_status(:success)
  end

  it 'returns http success if user is a teacher with course' do
    login_with teacher_without_course
    get :index
    expect(response).to redirect_to root_path
  end

  it 'redirect if user is a mentor' do
    login_with mentor
    get :index
    expect(response).to redirect_to root_path
  end
end
