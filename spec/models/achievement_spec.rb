# frozen_string_literal: true

# == Schema Information
#
# Table name: achievements
#
#  id         :bigint(8)        not null, primary key
#  points     :integer          not null
#  attendance :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#  lesson_id  :bigint(8)
#  kind       :integer          default("normal"), not null
#


require 'rails_helper'

RSpec.describe Achievement, type: :model do
  # Helpers definition
  let(:invalid_points)          { 13 }
  let(:invalid_points_length)   { 133 }

  # Errors definition
  let(:short_error) { I18n.t('activerecord.errors.models.achievement.attributes.points.too_short') }
  let(:long_error) { I18n.t('activerecord.errors.models.achievement.attributes.points.too_long') }
  let(:blank_error) { 'can\'t be blank' }
  let(:exist_error) { 'must exist' }
  let(:empty) { '' }
  let(:included_error) { I18n.t('activerecord.errors.models.achievement.attributes.points.inclusion') }
  let(:inclusion_kind) { %w[normal notebook thematic semester year] }

  it 'is valid with valid attributes' do
    achievement = FactoryBot.build(:valid_achievement)
    expect(achievement).to be_valid
  end

  it 'is valid without kind attribute' do
    achievement = FactoryBot.build(:valid_achievement, kind: nil)
    expect(achievement).to be_valid
  end

  it 'is allow inclusion value in the kind' do
    achievement = FactoryBot.build(:valid_achievement)
    inclusion_kind.each do |kind|
      achievement.kind = kind
      expect(achievement).to be_valid
    end
  end

  it 'is not valid without points' do
    achievement = FactoryBot.build(:valid_achievement, points: nil)
    expect(achievement).not_to be_valid
  end

  it 'is not valid without attendance' do
    achievement = FactoryBot.build(:valid_achievement, attendance: nil)
    expect(achievement).not_to be_valid
  end

  it 'is not valid without a lesson' do
    achievement = FactoryBot.build(:invalid_achievement_without_lesson)
    expect(achievement).not_to be_valid
  end

  it 'is not valid without a user' do
    achievement = FactoryBot.build(:invalid_achievement_without_user)
    expect(achievement).not_to be_valid
  end

  it 'is not valid with invalid points' do
    achievement = Achievement.create(
      FactoryBot.attributes_for(:valid_achievement, points: invalid_points)
    )
    expect(achievement.errors.messages[:points]).to eq [included_error]
  end

  it 'is not valid with long points length' do
    achievement = Achievement.create(
      FactoryBot.attributes_for(:valid_achievement, points: invalid_points_length)
    )
    expect(achievement.errors.messages[:points]).to eq [included_error, long_error]
  end

  it 'is not valid with short points length' do
    achievement = Achievement.create(
      FactoryBot.attributes_for(:valid_achievement, points: '')
    )
    expect(achievement.errors.messages[:points]).to eq [included_error, short_error]
  end

  it 'is not valid if user role is not student' do
    achievement = Achievement.create(
      FactoryBot.attributes_for(:invalid_achievement_with_user_not_student)
    )
    expect(achievement).not_to be_valid
  end
end
