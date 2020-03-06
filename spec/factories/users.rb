FactoryBot.define do
  factory :user do
    sequence(:name)       { |n| "yuki#{n}" }
    sequence(:email)      { |n| "tster#{n}@example.com" }
    password              'foobar'
    password_confirmation 'foobar'
  end
end
