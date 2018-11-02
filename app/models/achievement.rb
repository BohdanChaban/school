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

class Achievement < ApplicationRecord
  POINTS_RANGE        = 1..12
  POINTS_LENGTH_RANGE = 1..2
  KINDS               = %w[normal notebook thematic semester year].freeze

  belongs_to :user, -> { User.student }, inverse_of: :achievements
  belongs_to :lesson

  validates :points,     inclusion: { in: POINTS_RANGE }
  validates :points,     length:    { in: POINTS_LENGTH_RANGE }
  validates :attendance, inclusion: { in: [true, false] }

  enum kind: KINDS
end
