# frozen_string_literal: true

class Subject < ApplicationRecord
  validates :name, :image, presence: true
  validates :name, length: { in: 3..30 },
                   uniqueness: true,
                   format: { with: /\A[a-z_]+\z/,
                             message: 'Only a-z letters and _ symbol allowed' }
end
