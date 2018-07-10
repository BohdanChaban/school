# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :users, -> { User.student }, inverse_of: false

  NUMBER_LENGTH_RANGE   = 1..2
  NUMBER_RANGE          = 1..12

  PARALLEL_LENGTH_RANGE = 1
  PARALLELS             = %w[a b c].freeze

  validates :number, :parallel, presence: true
  validates :number, length: { in: NUMBER_LENGTH_RANGE }
  validates :number, inclusion: { in: NUMBER_RANGE }
  validates :parallel, length: { is: PARALLEL_LENGTH_RANGE }
  validates :parallel, inclusion: { in: PARALLELS }
end
