# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :subject, optional: false
  belongs_to :group, optional: false
  belongs_to :user, -> { User.teacher }, inverse_of: false, optional: false
  has_many :timeslots, dependent: :nullify
  validates :group_id, :subject_id, :user_id, presence: true

  has_many :themes, dependent: :destroy

  def student_access_forbidden?(user)
    user.student? && group_id != user.group_id
  end
end
