require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes"

  it "is not valid with too short name"
  it "is not valid with too short surname"
  it "is not valid with too long name"
  it "is not valid with too long surname"
  it "is not valid with duplicated email"
  it "is not valid with invalid email"

  it "is not valid without a name"
  it "is not valid without a surname"
  it "is not valid without a email"
  it "is not valid without a password"
  it "is not valid without a password_confirmation"

end
