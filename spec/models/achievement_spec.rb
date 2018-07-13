# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Achievement, type: :model do
  # Model parameters definition
  let(:achievement_params) do
    { points: 10,
      attendance: true }
  end

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

  let(:user_params) do
    { name: 'Foo',
      surname: 'Bar',
      email: 'foo@mail.com',
      password: '12345678',
      password_confirmation: '12345678' }
  end
  # Theme definition
  let(:theme) { Theme.create(theme_params) }

  # Lesson definition
  let(:lesson) do
    lesson_params[:theme_id] = theme.id
    Lesson.create(lesson_params)
  end

  # User definition
  let(:user) { User.create(user_params) }

  # Achievement definition
  let(:achievement) do
    achievement_params[:lesson_id] = lesson.id
    achievement_params[:user_id] = user.id
    Achievement.create(achievement_params)
  end

  # Helpers definition
  let(:invalid_points)          { 13 }
  let(:invalid_points_length)   { 133 }

  # Errors definition
  let(:short_error) { 'is too short (minimum is 1 character)' }
  let(:long_error) { 'is too long (maximum is 2 characters)' }
  let(:blank_error) { 'can\'t be blank' }
  let(:exist_error) { 'must exist' }
  let(:empty) { '' }
  let(:included_error) { 'is not included in the list' }

  it 'is valid with valid attributes' do
    expect(achievement).to be_valid
  end

  it 'is not valid without points' do
    achievement1 = Achievement.create(achievement_params.except(:points))
    expect(achievement1).not_to be_valid
  end

  it 'is not valid without points' do
    achievement1 = Achievement.create(achievement_params.except(:attendance))
    expect(achievement1).not_to be_valid
  end

  it 'is not valid without a lesson' do
    achievement1 = Achievement.create(achievement_params.except(:lesson_id))
    expect(achievement1).not_to be_valid
  end

  it 'is not valid without a user' do
    achievement1 = Achievement.create(achievement_params.except(:user_id))
    expect(achievement1).not_to be_valid
  end

  it 'is not valid with invalid points' do
    achievement_params[:points] = invalid_points
    expect(achievement).not_to be_valid
    expect(achievement.errors.messages[:points]).to eq [included_error]
  end

  it 'is not valid with long points length' do
    achievement_params[:points] = invalid_points_length
    expect(achievement).not_to be_valid
    expect(achievement.errors.messages[:points]).to eq [included_error, long_error]
  end

  it 'is not valid with short points length' do
    achievement_params[:points] = ''
    expect(achievement).not_to be_valid
    expect(achievement.errors.messages[:points]).to eq [included_error, short_error]
  end

  it 'can get achievements from lesson' do
    achievement
    expect(lesson.achievements.first).to eq achievement
  end

  it 'can get achievements from user' do
    achievement
    expect(user.achievements.first).to eq achievement
  end

  it 'is not valid if user role is not student' do
    user_params[:role] = :mentor
    expect(achievement).not_to be_valid
  end
end
