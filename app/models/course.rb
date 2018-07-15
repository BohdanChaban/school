# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :subject, optional: false
  belongs_to :group, optional: false
  belongs_to :user, -> { User.teacher }, inverse_of: false, optional: false

  validates :group_id, :subject_id, :user_id, presence: true

  has_many :themes, dependent: :destroy
end
