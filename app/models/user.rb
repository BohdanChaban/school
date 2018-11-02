# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string           default(""), not null
#  surname                :string           default(""), not null
#  email                  :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  role                   :integer          default("student"), not null
#  approved               :boolean          default(FALSE), not null
#  group_id               :integer
#

class User < ApplicationRecord
  NAME_LENGTH_RANGE  = 2..30
  EMAIL_LENGTH_RANGE = 6..40
  ROLES              = %w[student curator teacher mentor].freeze

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  belongs_to :group, optional: true

  has_many :courses,      dependent: :nullify
  has_many :groups,       through:   :courses
  has_many :subjects,     through:   :courses
  has_many :achievements, dependent: :destroy

  validates :name,
            :surname,
            :email, presence: true

  validates :name,     length:    { in: NAME_LENGTH_RANGE }
  validates :surname,  length:    { in: NAME_LENGTH_RANGE }
  validates :email,    length:    { in: EMAIL_LENGTH_RANGE }
  validates :approved, inclusion: { in: [true, false] }
  validates :role,     inclusion: { in: ROLES }
  validates :email,    uniqueness: true

  enum role: ROLES

  def hometasks(collect_option)
    hometasks = []
    if student?
      hometasks = send(collect_option, hometasks, group.courses)
    elsif teacher?
      hometasks = send(collect_option, hometasks, courses)
    end
    hometasks
  end

  def lessons
    Lesson.for_courses(courses)
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

  def collect_last(hometasks, enumerator)
    enumerator.each do |course|
      hometasks << Hometask.for_course(course).last
    end
    hometasks
  end
end
