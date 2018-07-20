# frozen_string_literal: true

FactoryBot.define do
  factory :timeslot do
    factory :valid_timeslot do
      day 'wednesday'
      number '3'
      association :course, factory: :valid_course_with_displayed

      factory :valid_timeslot_for_other_course do
        association :course, factory: :another_valid_course
      end
    end
    factory :another_timeslot do
      day 'wednesday'
      number '4'
    end
  end
end
