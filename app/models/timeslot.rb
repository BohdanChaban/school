# frozen_string_literal: true

class Timeslot < ApplicationRecord
  belongs_to :course

  DAYS = %w[monday tuesday wednesday thursday friday].freeze
  NUMBERS = %w[1 2 3 4 5 6 7 8 9].freeze

  validates :number, inclusion: { in: NUMBERS }
  validates :day, inclusion: { in: DAYS }
  validates :day, uniqueness: { scope: [:number, :course_id] }

  enum day: DAYS
  enum number: NUMBERS
end
