FactoryBot.define do
  factory :survey do
    competition
    competitor_email { Faker::Internet.email }
    competitor_competitions_count 5
  end
end
