# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :theme
  validates :topic, presence: true
  validates :topic, length: { in: 5..40 }
end
