# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :group
  belongs_to :user, -> { User.teacher }, inverse_of: false

  has_many :themes, dependent: :destroy
end
