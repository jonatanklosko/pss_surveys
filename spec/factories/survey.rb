FactoryBot.define do
  factory :survey do
    competition
    competitor_email { Faker::Internet.email }
    competitor_competitions_count { 5 }

    trait :submitted do
      submitted_at { DateTime.now }
    end
  end
end
