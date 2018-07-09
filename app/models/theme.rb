class Theme < ApplicationRecord
  LENGTH_RANGE = 5..40

  belongs_to :course

  validates :topic, presence: true, length: { in: LENGTH_RANGE }
end
