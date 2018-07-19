# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    factory :valid_group do
      number   5
      parallel 'b'

      factory :valid_group_with_user do
        after(:create) do |group|
          create(:valid_user_for_registration, group_id: group.id)
        end
      end

      factory :another_valid_group do
        number   6
        parallel 'a'
      end

      factory :valid_group_with_invalid_user_role do
        after(:create) do |group|
          create(:valid_user_for_teacher_role, group_id: group.id)
        end
      end
    end
  end
end
