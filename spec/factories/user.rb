FactoryGirl.define do
  factory :user, class: User do
    first_name "Hugh"
    last_name "Jass"
    email "hjass@getting.married"
    password "gettingmarried"
    admin false
  end

  factory :user2, class: User do
    first_name "Ben"
    last_name "Dover"
    email "bend@getting.married"
    password "gettingmarried"
    admin false
  end

  factory :admin, class: User do
    first_name "I.P."
    last_name "Freely"
    email "ipfreely@getting.married"
    password "gettingmarried"
    admin true
  end
end
