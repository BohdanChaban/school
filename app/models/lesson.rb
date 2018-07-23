# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :theme
  has_one :hometask, dependent: :destroy
  has_many :achievements, dependent: :destroy
  validates :topic, presence: true
  validates :topic, length: { in: 5..40 }
  scope :without_hometask, lambda {
                             left_outer_joins(:hometask).where(hometasks: { id: nil })
                           }
  scope :for_courses, lambda { |courses|
                        courses = courses.to_a.map!(&:id)
                        left_outer_joins(:theme).where(themes: { course_id: courses })
                      }
end
