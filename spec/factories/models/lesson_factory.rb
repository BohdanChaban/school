# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    factory :valid_lesson do
      topic 'Lorem'

      factory :valid_lesson_with_all_optional do
        description 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit'
        links 'link0.com link1.ua'
      end

      association :theme, factory: :with_all_optional
    end

    factory :invalid_lesson do
      topic 'Lorem'
    end
  end
end
