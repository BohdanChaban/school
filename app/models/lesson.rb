# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :theme
  has_one :hometask
  validates :topic, presence: true
  validates :topic, length: { in: 5..40 }
end
