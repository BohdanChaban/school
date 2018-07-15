# frozen_string_literal: true

FactoryBot.define do
  factory :hometask do
    factory :valid_hometask do
      description 'Lorem ipsum dolor sit amet'

      factory :valid_hometask_with_all_optional do
        link 'link0.com'
      end

      association :lesson, factory: :valid_lesson_with_all_optional
    end

    factory :invalid_hometask do
      description 'Lorem'
    end
  end
end
