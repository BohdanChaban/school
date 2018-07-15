# frozen_string_literal: true

RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  config.excluded_models = ['Admin']

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # User model fields configuration
  config.model 'User' do
    list do
      field :name
      field :surname
      field :email
      field :role
      field :approved
    end

    show do
      field :name
      field :surname
      field :email
      field :role
      field :approved
      field :last_sign_in_at
    end

    edit do
      field :name
      field :surname
      field :email
      field :role
      field :approved
    end

    create do
      field :name
      field :surname
      field :email
      field :role
      field :approved
      field :password
      field :password_confirmation
    end
  end

  # Group model fields configuration
  config.model 'Group' do
    list do
      field :number
      field :parallel
    end

    show do
      field :number
      field :parallel
      field :courses
    end

    edit do
      field :number
      field :parallel
    end
  end

  # Subject model fields configuration
  config.model 'Subject' do
    list do
      field :name
      field :image
    end

    show do
      field :name
      field :image
    end

    edit do
      field :name
      field :image
    end
  end

  # Theme model fields configuration
  config.model 'Theme' do
    list do
      field :topic
      field :course
    end
  end
end
