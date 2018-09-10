# frozen_string_literal: true

class Achievement < ApplicationRecord
  belongs_to :user, -> { User.student }, inverse_of: :achievements
  belongs_to :lesson, optional: true
  belongs_to :theme, optional: true

  POINTS_RANGE = 1..12
  POINTS_LENGTH_RANGE = 1..2

  KINDS = %w[normal notebook thematic semester year].freeze

  validates :points, inclusion: { in: POINTS_RANGE }
  validates :points, length: { in: POINTS_LENGTH_RANGE }
  validates :attendance, inclusion: { in: [true, false] }

  validate :normal_with_lesson

  enum kind: KINDS

  def normal_with_lesson
    return unless kind == Achievement::KINDS[0] && lesson.blank?
    errors.add(:lesson, I18n.t('activerecord.errors.models.achievement.attributes.lesson.blank'))
  end
end
