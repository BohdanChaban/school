# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hometask, type: :model do
  # Model parameters definition
  let(:lesson_params) do
    { topic: 'Lesson_topic',
      description: 'some description',
      links: 'some links' }
  end

  let(:theme_params) do
    { topic: 'Lorem',
      description: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit',
      links: 'link0.com link1.ua' }
  end

  let(:hometask_params) do
    { description: 'Hometask description',
      link: 'hometask link' }
  end

  # Theme definition
  let(:theme) { Theme.create(theme_params) }

  # Lesson definition
  let(:lesson) do
    lesson_params[:theme_id] = theme.id
    Lesson.create(lesson_params)
  end

  # Hometask definition
  let(:hometask) do
    hometask_params[:lesson_id] = lesson.id
    Hometask.create(hometask_params)
  end

  # Helpers definition
  let(:short_text)    { 'f' * 2 }

  # Errors definition
  let(:short_error)   { 'is too short (minimum is 3 characters)' }
  let(:blank_error) { 'can\'t be blank' }
  let(:exist_error) { 'must exist' }
  let(:empty) { '' }

  it 'is valid with valid attributes' do
    expect(hometask).to be_valid
  end

  it 'is not valid with too short description' do
    hometask.description = short_text
    expect(hometask).not_to be_valid
    expect(hometask.errors.messages[:description]).to eq [short_error]
  end

  it 'is not valid without a description' do
    hometask_params[:lesson_id] = lesson.id
    hometask1 = Hometask.create(hometask_params.except(:description))
    expect(hometask1).not_to be_valid
    expect(hometask1.errors.messages[:description]).to eq [blank_error, short_error]
  end

  it 'is valid without a link' do
    hometask_params[:lesson_id] = lesson.id
    hometask1 = Hometask.create(hometask_params.except(:link))
    expect(hometask1).to be_valid
    expect(hometask1.link).to eq(empty)
  end

  it 'is not valid without a lesson' do
    hometask1 = Hometask.create(hometask_params.except(:lesson_id))
    expect(hometask1).not_to be_valid
    expect(hometask1.errors.messages[:lesson]).to eq [exist_error]
  end
end
