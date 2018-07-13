# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:student_role) { 'Student' }
  let(:password) { 'q1w2e3' }
  let(:other_role) { 'mentor' }
  let(:email_suffix) { '@school70.ua' }
  let(:groups_param) do
    [
      { number: 1, parallel: 'a' },
      { number: 6,  parallel: 'b' },
      { number: 12, parallel: 'c' }
    ]
  end

  let(:list) { %w[first second third] }
  let(:students_list) { list }
  let(:other_users_list) { [list.first] }

  before do
    groups_param.each do |group_param|
      Group.new(group_param).save
    end
  end

  before do
    students_list.each do |surname|
      student_param = {
        name: student_role,
        surname: surname,
        email: student_role + '.' + surname + email_suffix,
        password: password,
        group_id: Group.first.id
      }
      User.new(student_param).save
    end
  end

  before do
    other_users_list.each do |surname|
      other_user_param = {
        name: other_role,
        surname: surname,
        email: other_role + '.' + surname + email_suffix,
        password: password,
        role: other_role
      }
      User.new(other_user_param).save
    end
  end

  describe 'GET index' do
    it 'redirect to root path without auth.' do
      get :index
      expect(response).to redirect_to user_session_path
    end

    it 'redirect to show template with student role' do
      current_user = User.first
      login_with current_user
      get :index
      expect(response).to redirect_to "/groups/#{current_user.group_id}"
    end

    it 'redner index template with role not student role' do
      login_with User.last
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    it 'renders the show template with self student group id' do
      current_user = User.first
      login_with current_user
      get :show, params: { id: current_user.group_id }
      expect(response).to render_template('show')
    end

    it 'renders the show template with not student role by some group id' do
      login_with User.last
      get :show, params: { id: Group.first.id }
      expect(response).to render_template('show')
    end

    it 'redirect to root path with not self student group id' do
      current_user = User.first
      other_user = User.second
      other_user[:group_id] = Group.second.id
      login_with current_user
      get :show, params: { id: other_user.group_id }
      expect(response).to redirect_to root_path
    end
  end
end
