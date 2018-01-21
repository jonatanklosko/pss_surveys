FactoryBot.define do
  factory :survey_answer do
    survey
    survey_question
    rating 5
    comment { Faker::Lorem.sentence }
  end
end
