FactoryBot.define do
  factory :user do
    sequence(:wca_user_id)
    name { Faker::Name.name }
    wca_id { Date.today.year.to_s + name.gsub(/\W/, "").first(4).upcase + ("01".."99").to_a.sample }
  end
end
