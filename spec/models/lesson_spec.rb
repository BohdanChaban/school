# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lesson, type: :model do
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
    lesson = FactoryBot.create(:valid_lesson_with_all_optional)
    expect(lesson).to be_valid
  end

  it 'is not valid with too short topic' do
    lesson = FactoryBot.build(:valid_lesson_with_all_optional, topic: short_text)
    expect(lesson).not_to be_valid
    expect(lesson.errors.messages[:topic]).to eq [short_error]
  end

  it 'is not valid with too long topic' do
    lesson = FactoryBot.build(:valid_lesson_with_all_optional, topic: long_text)
    expect(lesson).not_to be_valid
    expect(lesson.errors.messages[:topic]).to eq [long_error]
  end

  it 'is not valid without a topic' do
    lesson = FactoryBot.build(:valid_lesson_with_all_optional, topic: nil)
    expect(lesson).not_to be_valid
    expect(lesson.errors.messages[:topic]).to eq [blank_error, short_error]
  end

  it 'is valid without a description' do
    lesson = FactoryBot.build(:valid_lesson)
    expect(lesson).to be_valid
    expect(lesson.description).to eq(empty)
  end

  it 'is valid without a links' do
    lesson = FactoryBot.build(:valid_lesson)
    expect(lesson).to be_valid
    expect(lesson.links).to eq(empty)
  end

  it 'is not valid without a theme' do
    lesson = FactoryBot.build(:invalid_lesson)
    expect(lesson).not_to be_valid
    expect(lesson.errors.messages[:theme]).to eq [exist_error]
  end
end
