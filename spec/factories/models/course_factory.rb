# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    factory :valid_course do
      association :group, factory: :valid_group_with_user
      association :subject, factory: :valid_subject
      association :user, factory: :valid_user_for_teacher_role

      factory :valid_course_with_displayed do
        displayed true
      end
    end
  end
end
