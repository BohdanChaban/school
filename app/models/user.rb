# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group, optional: true

  has_many :courses, dependent: :nullify
  has_many :groups, through: :courses
  has_many :subjects, through: :courses

  has_many :achievements, dependent: :destroy

  NAME_LENGTH_RANGE = 2..30
  EMAIL_LENGTH_RANGE = 6..40
  ROLES = %w[student curator teacher mentor].freeze

  # validates :group_id, presence: true, if: -> { self.student? }

  validates :name, :surname, :email, presence: true
  validates :name, length: { in: NAME_LENGTH_RANGE }
  validates :surname, length: { in: NAME_LENGTH_RANGE }
  validates :email, length: { in: EMAIL_LENGTH_RANGE }
  validates :approved, inclusion: { in: [true, false] }
  validates :role, inclusion: { in: ROLES }

  enum role: ROLES

  def hometasks
    hometasks = []
    if student?
      hometasks = collect(hometasks, group.courses)
    elsif teacher?
      hometasks = collect(hometasks, courses)
    end
    hometasks
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if approved?
      super
    else
      :not_approved
    end
  end

  private

  def collect(hometasks, enumerator)
    enumerator.each do |course|
      hometasks << Hometask.for_course(course).last
    end
    hometasks
  end
end
