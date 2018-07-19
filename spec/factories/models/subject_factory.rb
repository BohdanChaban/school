# frozen_string_literal: true

FactoryBot.define do
  factory :subject do
    factory :valid_subject do
      name 'algebra'
      image 'subjects/algebra.png'
    end

    factory :another_valid_subject do
      name 'english'
      image 'subjects/english.png'
    end
  end
end
