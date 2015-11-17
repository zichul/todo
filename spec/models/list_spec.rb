require 'rails_helper'

RSpec.describe List, type: :model do

  it "can't be created without user assigned" do
    list = build :list, :user => nil
    expect(list).to be_invalid
    list.user = create :user
    expect(list).to be_valid
  end

  it "has secure token assigned after create" do
    list = build :list
    expect(list).to be_valid
    list.save
    expect(list.token).to be_present
  end

end
