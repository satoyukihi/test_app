FactoryBot.define do
  factory :comment do
    user
    topic
    content 'MyText'
  end
end
