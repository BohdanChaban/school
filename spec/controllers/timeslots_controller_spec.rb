# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeslotsController, type: :controller do
  let(:timeslot) { FactoryBot.create(:valid_timeslot) }
  let(:student) { FactoryBot.create(:valid_user_for_registration, group_id: timeslot.group_id) }

  it 'returns http success if user is a student' do
    login_with student
    get :index
    expect(response).to have_http_status(:success)
  end
end
