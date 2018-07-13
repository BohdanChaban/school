# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :courses, dependent: :nullify
  has_many :groups, through: :courses
  has_many :users, -> { User.teacher }, inverse_of: false, through: :courses

  validates :name, :image, presence: true
  validates :name, length: { in: 3..30 },
                   uniqueness: true,
                   format: { with: /\A[a-z_]+\z/,
                             message: 'Only a-z letters and _ symbol allowed' }
end
