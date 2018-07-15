# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    factory :valid_achievement do
      points 10
      attendance true

      association :user, factory: :valid_user_for_registration, email: 'random_email@y.ru'
      association :lesson, factory: :valid_lesson_with_all_optional
    end

    factory :invalid_achievement do
      factory :invalid_achievement_without_user do
        points 10
        attendance true
        association :lesson, factory: :valid_lesson_with_all_optional
      end
      factory :invalid_achievement_without_lesson do
        points 10
        attendance true
        association :user, factory: :valid_user_for_registration, email: 'random_email@ya.ru'
      end
      factory :invalid_achievement_with_user_not_student do
        points 10
        attendance true
        association :user, factory: :valid_user_for_mentor_role
        association :lesson, factory: :valid_lesson_with_all_optional
      end
    end
  end
end
