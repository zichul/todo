FactoryGirl.define do
  factory :list do
    title "Todo List"
    user {User.any? ? User.first : create( :user )}
  end
end
