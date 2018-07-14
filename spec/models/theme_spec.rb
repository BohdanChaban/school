# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theme, type: :model do
  # Helpers definition
  let(:short_text) { 'f' }
  let(:long_text)  { short_text * 41 }
  let(:empty)      { '' }

  # Errors definition
  let(:short_error_topic)   { 'is too short (minimum is 5 characters)' }
  let(:long_error_topic)    { 'is too long (maximum is 40 characters)' }
  let(:invalid_error)      { 'is invalid' }
  let(:blank_error)        { 'can\'t be blank' }

  it 'is valid with valid attributes' do
    theme = FactoryBot.create(:with_all_optional)
    expect(theme).to be_valid
  end
  it 'is valid without description' do
    theme = FactoryBot.create(:valid_theme)
    expect(theme.description).to eq(empty)
  end
  it 'is valid without links' do
    theme = FactoryBot.create(:valid_theme)
    expect(theme.links).to eq(empty)
  end

  it 'is invalid with long topic' do
    theme = FactoryBot.build(:valid_theme, topic: long_text)
    expect(theme).not_to be_valid
    expect(theme.errors.messages[:topic]).to eq [long_error_topic]
  end
  it 'is invalid with short topic' do
    theme = FactoryBot.build(:valid_theme, topic: short_text)
    expect(theme).not_to be_valid
    expect(theme.errors.messages[:topic]).to eq [short_error_topic]
  end
  it 'is invalid without topic' do
    theme = FactoryBot.build(:valid_theme, topic: nil)
    expect(theme).not_to be_valid
    expect(theme.errors.messages[:topic]).to eq [blank_error, short_error_topic]
  end
end
