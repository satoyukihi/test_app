FactoryBot.define do
  factory :topic do
    sequence(:title) { |n| "test#{n}" }
    user

    after(:create) do |topic|
      create(:tag_relationship, topic: topic, tag: create(:tag))
    end
  end
end
