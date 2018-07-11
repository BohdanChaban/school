# frozen_string_literal: true

class Theme < ApplicationRecord
  belongs_to :course

  LENGTH_RANGE = 5..40

  validates :topic, presence: true, length: { in: LENGTH_RANGE }
end
