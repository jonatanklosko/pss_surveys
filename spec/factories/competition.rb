FactoryBot.define do
  factory :competition do
    sequence(:name) { |n| "Competition #{n} #{Date.today.year}" }
    wca_competition_id { name.gsub /\s+/, "" }
    start_date { 2.weeks.ago }
    end_date { start_date }
    competitors_count 100

    trait :surveys_closed do
      surveys_closed_at Time.now
    end
  end
end
