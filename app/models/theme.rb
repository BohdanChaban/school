# frozen_string_literal: true

class Theme < ApplicationRecord
  has_many :lessons, dependent: :destroy
  LENGTH_RANGE = 5..40
  validates :topic, presence: true, length: { in: LENGTH_RANGE }
end
