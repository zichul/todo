FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@example.com" }
    password "password123"
    
    trait :static do
      email 'konkozicki@gmail.com'
      password "password123"
    end

    trait :bad_email do
      email "example.pl"
    end
    trait :bad_password do
      password_confirmation "password1234"
    end
  end
end
