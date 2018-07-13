# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :theme
  has_one :hometask, dependent: :destroy
  has_many :achievements, dependent: :destroy
  validates :topic, presence: true
  validates :topic, length: { in: 5..40 }
end
