# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  # Helpers definition
  let(:article) { FactoryBot.create(:valid_article) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: article.id }
      expect(response).to have_http_status(:success)
    end
  end
end
