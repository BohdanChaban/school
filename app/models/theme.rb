# frozen_string_literal: true

class Theme < ApplicationRecord
  LENGTH_RANGE = 5..40
  belongs_to :course, optional: false

  has_many :lessons, dependent: :destroy

  validates :topic, presence: true, length: { in: LENGTH_RANGE }
  validates :course, presence: true
end
