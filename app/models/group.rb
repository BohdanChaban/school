# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id         :bigint(8)        not null, primary key
#  number     :integer          not null
#  parallel   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  NUMBER_LENGTH_RANGE   = 1..2
  NUMBER_RANGE          = 1..12
  PARALLEL_LENGTH_RANGE = 1
  PARALLELS             = %w[a b c].freeze

  has_many :courses,  dependent: :nullify
  has_many :subjects, through:   :courses
  has_many :users, -> { User.student }, inverse_of: false

  validates :number,
            :parallel, presence: true

  validates :number,   length:     { in: NUMBER_LENGTH_RANGE }
  validates :number,   inclusion:  { in: NUMBER_RANGE }
  validates :number,   uniqueness: { scope: :parallel }
  validates :parallel, length:     { is: PARALLEL_LENGTH_RANGE }
  validates :parallel, inclusion:  { in: PARALLELS }

  def name
    "#{number}#{parallel}"
  end
end
