# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theme, type: :model do
  let(:theme_params) do
    { topic: 'Lorem',
      description: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit',
      links: 'link0.com link1.ua' }
  end

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
    theme = Theme.create(theme_params)
    expect(theme).to be_valid
  end
  it 'is valid without description' do
    theme = Theme.create(theme_params.except(:description))
    expect(theme).to be_valid
    expect(theme.description).to eq(empty)
  end
  it 'is valid without links' do
    theme = Theme.create(theme_params.except(:links))
    expect(theme).to be_valid
    expect(theme.links).to eq(empty)
  end

  it 'is invalid with long topic' do
    theme_params[:topic] = long_text
    theme = Theme.create(theme_params)
    expect(theme).not_to be_valid
    expect(theme.errors.messages[:topic]).to eq [long_error_topic]
  end
  it 'is invalid with short topic' do
    theme_params[:topic] = short_text
    theme = Theme.create(theme_params)
    expect(theme).not_to be_valid
    expect(theme.errors.messages[:topic]).to eq [short_error_topic]
  end
  it 'is invalid without topic' do
    theme = Theme.create(theme_params.except(:topic))
    expect(theme).not_to be_valid
    expect(theme.errors.messages[:topic]).to eq [blank_error, short_error_topic]
  end
end
