# frozen_string_literal: true

class Timeslot < ApplicationRecord
  DAYS    = %w[monday tuesday wednesday thursday friday].freeze
  NUMBERS = %w[1 2 3 4 5 6 7 8 9].freeze
  belongs_to :course

  validates :number, inclusion: { in: NUMBERS }
  validates :day, inclusion: { in: DAYS }
  validates :day, uniqueness: { scope: %i[number group_id] }
  before_validation :set_group_id

  enum day: DAYS
  enum number: NUMBERS

  private

  def set_group_id
    self.group_id = course.group_id
  end
end
