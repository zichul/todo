require 'rails_helper'

RSpec.describe User, type: :model do
  it "cannot be saved if email isn't unique" do
    expect(User.count).to eq(0)
    create :user, :static
    expect(User.count).to eq(1)
    duplicated_user = build :user, :static
    expect(duplicated_user).to be_invalid
  end

  it "can be saved for unique values" do
    expect(User.count).to eq(0)
    number = 10
    number.times do
      create :user
    end
    expect(User.count).to eq(number)
  end

  it "cannot be save with too short password" do
    user = build :user, :password => 'pass123'
    expect(user).to be_invalid
  end

  it "cannot be saved with bad email format" do
    user = build :user, :bad_email
    expect(user).to be_invalid
  end
  
  it "cannot be saved with blank email or password" do
    user = build :user, email: ""
    expect(user).to be_invalid
    user = build :user, password: ""
    expect(user).to be_invalid
    user = build :user, email: nil
    expect(user).to be_invalid
    user = build :user, password: nil
    expect(user).to be_invalid
  end

  it "cannot be saved with bad confirmation of password" do
    user = build :user, :bad_password
    expect(user).to be_invalid
    user = build :user, password_confirmation: ""
    expect(user).to be_invalid
  end
end
