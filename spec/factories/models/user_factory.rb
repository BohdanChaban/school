# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # Factories for valid user
    factory :valid_user do
      @pass = 'password'

      email 'username@example.com'
      name 'Username'
      surname 'Usersurname'
      password @pass

      factory :valid_user_for_registration do
        password_confirmation @pass
      end

      factory :valid_user_for_teacher_role do
        role 'teacher'
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