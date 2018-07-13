# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:lesson_params) do
    { topic: 'Test_topic',
      description: 'some description',
      links: 'some links' }
  end

  let(:theme_params) do
    { topic: 'Lorem',
      description: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit',
      links: 'link0.com link1.ua' }
  end

  # Theme definition
  let(:theme) { Theme.create(theme_params) }

  # Lesson definition
  let(:lesson) do
    lesson_params[:theme_id] = theme.id
    Lesson.create(lesson_params)
  end

  # Helpers definition
  let(:short_text)    { 'f' * 4 }
  let(:long_text)     { 'f' * 41 }

  # Errors definition
  let(:short_error)   { 'is too short (minimum is 5 characters)' }
  let(:long_error)    { 'is too long (maximum is 40 characters)' }
  let(:blank_error) { 'can\'t be blank' }
  let(:exist_error) { 'must exist' }
  let(:empty) { '' }
  it 'is valid with valid attributes' do
    expect(lesson).to be_valid
  end

  it 'is not valid with too short topic' do
    lesson.topic = short_text
    expect(lesson).not_to be_valid
    expect(lesson.errors.messages[:topic]).to eq [short_error]
  end

  it 'is not valid with too long topic' do
    lesson.topic = long_text
    expect(lesson).not_to be_valid
    expect(lesson.errors.messages[:topic]).to eq [long_error]
  end

  it 'is not valid without a topic' do
    lesson_params[:topic] = nil
    expect(lesson).not_to be_valid
    expect(lesson.errors.messages[:topic]).to eq [blank_error, short_error]
  end

  it 'is valid without a description' do
    lesson_params[:theme_id] = theme.id
    lesson1 = Lesson.create(lesson_params.except(:description))
    expect(lesson1).to be_valid
    expect(lesson1.description).to eq(empty)
  end

  it 'is valid without a links' do
    lesson_params[:theme_id] = theme.id
    lesson1 = Lesson.create(lesson_params.except(:links))
    expect(lesson1).to be_valid
    expect(lesson1.links).to eq(empty)
  end

  it 'is not valid without a theme' do
    lesson1 = Lesson.create(lesson_params.except(:theme_id))
    expect(lesson1).not_to be_valid
    expect(lesson1.errors.messages[:theme]).to eq [exist_error]
  end
end
