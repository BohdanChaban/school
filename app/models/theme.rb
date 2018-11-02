# frozen_string_literal: true

# == Schema Information
#
# Table name: themes
#
#  id          :bigint(8)        not null, primary key
#  topic       :string           default(""), not null
#  description :text             default(""), not null
#  links       :text             default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :bigint(8)
#

class Theme < ApplicationRecord
  LENGTH_RANGE = 5..40

  belongs_to :course, optional: false

  has_many :lessons, dependent: :destroy

  validates :topic,  presence: true, length: { in: LENGTH_RANGE }
  validates :course, presence: true
end
