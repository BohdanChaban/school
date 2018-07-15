# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hometask, type: :model do
  # Helpers definition
  let(:short_text)    { 'f' * 2 }

  # Errors definition
  let(:short_error)   { 'is too short (minimum is 3 characters)' }
  let(:blank_error) { 'can\'t be blank' }
  let(:exist_error) { 'must exist' }
  let(:empty) { '' }

  it 'is valid with valid attributes' do
    hometask = FactoryBot.create(:valid_hometask_with_all_optional)
    expect(hometask).to be_valid
  end

  it 'is not valid with too short description' do
    hometask = FactoryBot.build(:valid_hometask, description: short_text)
    expect(hometask).not_to be_valid
    expect(hometask.errors.messages[:description]).to eq [short_error]
  end

  it 'is not valid without a description' do
    hometask = FactoryBot.build(:valid_hometask, description: nil)
    expect(hometask).not_to be_valid
    expect(hometask.errors.messages[:description]).to eq [blank_error, short_error]
  end

  it 'is valid without a link' do
    hometask = FactoryBot.build(:valid_hometask)
    expect(hometask).to be_valid
    expect(hometask.link).to eq(empty)
  end

  it 'is not valid without a lesson' do
    hometask = FactoryBot.build(:invalid_hometask)
    expect(hometask).not_to be_valid
    expect(hometask.errors.messages[:lesson]).to eq [exist_error]
  end
end
