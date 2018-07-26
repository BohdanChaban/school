# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  # Helpers definition
  let(:string) { 'str' }
  let(:int) { 123 }

  it 'is valid with all valid attributes' do
    course = FactoryBot.build(:valid_course_with_displayed)
    expect(course).to be_valid
  end
  it 'is valid without displayed attribute' do
    course = FactoryBot.build(:valid_course)
    expect(course).to be_valid
  end
  it 'is valid with displayed attribute type string' do
    course = FactoryBot.build(:valid_course, displayed: string)
    expect(course).to be_valid
  end
  it 'is valid with displayed attribute type int' do
    course = FactoryBot.build(:valid_course, displayed: int)
    expect(course).to be_valid
  end
  it 'is valid with displayed attribute false' do
    course = FactoryBot.build(:valid_course, displayed: false)
    expect(course).to be_valid
  end

  it 'is invalid without group_id attribute' do
    course = FactoryBot.build(:valid_course, group_id: nil)
    expect(course).to_not be_valid
  end
  it 'is invalid with group_id attribute type string' do
    course = FactoryBot.build(:valid_course, group_id: string)
    expect(course).to_not be_valid
  end
  it 'is invalid without subject_id attribute' do
    course = FactoryBot.build(:valid_course, subject_id: nil)
    expect(course).to_not be_valid
  end
  it 'is invalid with subject_id attribute type string' do
    course = FactoryBot.build(:valid_course, subject_id: string)
    expect(course).to_not be_valid
  end
  it 'is invalid without user_id attribute' do
    course = FactoryBot.build(:valid_course, user_id: nil)
    expect(course).to_not be_valid
  end
  it 'is invalid with user_id attribute type string' do
    course = FactoryBot.build(:valid_course, user_id: string)
    expect(course).to_not be_valid
  end
  it 'is valid with empty achievements_hash' do
    course = FactoryBot.build(:valid_course)
    expect(course).to be_valid
    expect(course.achievements_hash).to eq({})
  end

  it 'is valid with not empty achievements_hash' do
    user = FactoryBot.create(:valid_user_for_registration)
    course = FactoryBot.create(:valid_course)
    theme = FactoryBot.create(:valid_theme, course: course)
    lesson = FactoryBot.create(:valid_lesson_with_all_optional, theme: theme)
    ach = FactoryBot.create(:valid_achievement, lesson: lesson, user: user)

    course_achievements = course.achievements_hash
    lesson_achievements = course_achievements[lesson.id]
    achievement_details = lesson_achievements[ach.user.id]

    expect(course).to be_valid
    expect(ach).to be_valid
    expect(course_achievements).to_not be_empty
    expect(lesson_achievements).to_not be_empty
    expect(achievement_details).to eq(points: ach.points, type: ach.kind, attendance: ach.attendance)
  end
end
