# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  displayed  :boolean          default(TRUE), not null
#  group_id   :bigint(8)        not null
#  subject_id :bigint(8)        not null
#  user_id    :bigint(8)        not null
#

class Course < ApplicationRecord
  belongs_to :subject, optional: false
  belongs_to :group,   optional: false
  belongs_to :user, -> { User.teacher }, inverse_of: false, optional: false

  has_many :timeslots, dependent: :nullify
  has_many :themes,    dependent: :destroy

  validates :group_id, :subject_id, :user_id, presence: true

  def student_access_forbidden?(user)
    user.student? && group_id != user.group_id
  end

  def achievements_hash
    hash = {}
    themes.each do |theme|
      theme.lessons.each do |el|
        (hash[el.id] = {}) && (el.achievements.each { |av| hash[el.id][av.user.id] = acv(av) })
      end
    end
    hash
  end

  def acv(ach)
    { points: ach.points, type: ach.kind, attendance: ach.attendance }
  end
end
