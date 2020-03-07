FactoryBot.define do
  factory :topic do
    sequence(:title) { |n| "test#{n}" }
    user
  end
end
