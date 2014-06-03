FactoryGirl.define do

  factory :user do
    email                  "user@example.com"
    password               "password"
    password_confirmation  "password"
  end

  factory :second_user, class: User do
    email                  "email@email.com"
    password               "password"
    password_confirmation  "password"
  end

end