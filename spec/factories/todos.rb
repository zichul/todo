FactoryGirl.define do
  factory :todo do
    name "Make a sandwich"
    list {List.any? ? List.first : create( :list )}
    check false
  end

end
