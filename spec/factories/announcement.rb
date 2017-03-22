FactoryGirl.define do
  factory :announcement do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    open true
    animal "dog"
    anno_type "lost"
    place "opole"
    association :user, factory: :user
  end
end
