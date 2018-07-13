# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let(:user_params) do
    {
      name: 'sad',
      surname: 'd',
      email: 'foo@mail.com',
      password: '12345678',
      password_confirmation: '12345678',
      approved: true
    }
  end
  let(:user) { User.create(user_params) }
  describe 'GET #index' do
    it 'returns http success if user is authenticated' do
      login_with user
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'returns http found if user is not authenticated' do
      get :index
      expect(response).to have_http_status(:found)
    end
  end
end
