# frozen_string_literal: true

FactoryBot.define do
  factory :theme do
    factory :valid_theme do
      topic 'Lorem'

      factory :with_all_optional do
        description 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit'
        links 'link0.com link1.ua'
      end

      association :course, factory: :valid_course_with_displayed
    end
  end
end
