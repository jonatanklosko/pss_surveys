FactoryBot.define do
  factory :survey_question do
    question { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }

    trait :delegate do
      delegate { true }
    end
  end
end
