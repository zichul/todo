require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "has toggle method" do
    todo = create :todo
    expect(todo.check).to be_falsey
    todo.toggle_check
    expect(todo.check).to be_truthy
  end
end
