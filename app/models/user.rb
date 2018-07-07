# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :surname, :email, presence: true
  validates :name, length: { in: 2..30 }
  validates :surname, length: { in: 2..30 }
  validates :email, length: { in: 6..40 }
  validates :approved, inclusion: { in: [true, false] }

  ROLES = %i[student curator teacher mentor].freeze
  enum role: ROLES
end
