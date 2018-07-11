class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :group
  belongs_to :user, -> { User.teacher }

  has_many :themes
end
