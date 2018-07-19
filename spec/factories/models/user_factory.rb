# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # Factories for valid user
    factory :valid_user do
      @pass = 'password'
      sequence(:email) { |n| "username#{n}@example.com" }
      sequence(:name) { |n| "username#{n}" }
      sequence(:surname) { |n| "usersurname#{n}" }
      password @pass

      factory :valid_user_for_registration do
        password_confirmation @pass
      end

      factory :valid_user_for_mentor_role do
        sequence(:email) { |n| "mentor#{n}@example.com" }
        role 'mentor'
      end

      factory :valid_user_for_teacher_role do
        sequence(:email) { |n| "teacher#{n}@example.com" }
        role 'teacher'
      end

      factory :valid_user_with_group do
        after(:create) do |user|
          create(:valid_group, users: [user])
        end
      end
    end

    # Factories for invalid user
    factory :invalid_user do
      factory :invalid_user_without_email do
        @pass = 'password'

        name 'Username'
        surname 'Usersurname'
        password @pass
        password_confirmation @pass
      end

      factory :invalid_user_without_name do
        @pass = 'password'

        email 'username@i.t'
        surname 'Usersurname'
        password @pass
        password_confirmation @pass
      end

      factory :invalid_user_without_surname do
        @pass = 'password'

        email 'username@i.t'
        name 'Username'
        password @pass
        password_confirmation @pass
      end

      factory :invalid_user_without_password do
        email 'username@i.t'
        name 'Username'
        surname 'Usersurname'
      end
    end
  end
end
