FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Smith"
    email "johnsmith@email.com"
    password "gettingmarried"
    admin false
  end

  factory :admin, class: User do
    first_name "Van"
    last_name "Le"
    email "van@getting.married"
    password "gettingmarried"
    admin true
  end
end
