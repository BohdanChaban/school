# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) do
    { name: 'Foo',
      surname: 'Bar',
      email: 'foo@mail.com',
      password: '12345678',
      password_confirmation: '12345678' }
  end
  # Helpers definition
  let(:short_text)    { 'f' }
  let(:long_text)     { 'f' * 31 }
  let(:invalid_email) { 'fff' }

  # Errors definition
  let(:short_error)   { 'is too short (minimum is 2 characters)' }
  let(:long_error)    { 'is too long (maximum is 30 characters)' }
  let(:short_error)   { 'is too short (minimum is 2 characters)' }
  let(:invalid_error) { 'is invalid' }
  let(:blank_error)   { 'can\'t be blank' }

  let(:confirmation_error) { 'doesn\'t match Password' }

  it 'is valid with valid attributes' do
    user = User.create(user_params)
    expect(user).to be_valid
  end

  it 'is not valid with too short name' do
    user = User.create(user_params)
    user.name = short_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:name]).to eq [short_error]
  end

  it 'is not valid with too short surname' do
    user = User.create(user_params)
    user.surname = short_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:surname]).to eq [short_error]
  end

  it 'is not valid with too long name' do
    user = User.create(user_params)
    user.name = long_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:name]).to eq [long_error]
  end

  it 'is not valid with too long surname' do
    user = User.create(user_params)
    user.surname = long_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:surname]).to eq [long_error]
  end

  it 'is not valid with duplicated email' do
  end

  it 'is not valid with invalid email' do
    user = User.create(user_params)
    user.email = invalid_email
    expect(user).not_to be_valid
    expect(user.errors.messages[:email]).to eq [invalid_error]
  end

  it 'is not valid without a name' do
    user = User.create(user_params.except(:name))
    expect(user).not_to be_valid
    expect(user.errors.messages[:name]).to eq [short_error]
  end

  it 'is not valid without a surname' do
    user = User.create(user_params.except(:surname))
    expect(user).not_to be_valid
    expect(user.errors.messages[:surname]).to eq [short_error]
  end

  it 'is not valid without a email' do
    user = User.create(user_params.except(:email))
    expect(user).not_to be_valid
    expect(user.errors.messages[:email]).to eq [blank_error]
  end

  it 'is not valid without a password' do
    user = User.create(user_params.except(:password))
    expect(user).not_to be_valid
    expect(user.errors.messages[:password]).to eq [blank_error]
  end
end
