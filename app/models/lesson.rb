# frozen_string_literal: true

# == Schema Information
#
# Table name: lessons
#
#  id          :bigint(8)        not null, primary key
#  topic       :string           default(""), not null
#  description :text             default(""), not null
#  links       :text             default(""), not null
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  theme_id    :bigint(8)
#

class Lesson < ApplicationRecord
  belongs_to :theme

  has_one   :hometask,     dependent: :destroy
  has_many  :achievements, dependent: :destroy

  validates :topic, presence: true
  validates :topic, length:   { in: 5..40 }

  scope :without_hometask, -> { left_outer_joins(:hometask).where(hometasks: { id: nil }) }

  scope :for_courses, lambda { |courses|
                        courses = courses.to_a.map!(&:id)
                        left_outer_joins(:theme).where(themes: { course_id: courses })
                      }
end
