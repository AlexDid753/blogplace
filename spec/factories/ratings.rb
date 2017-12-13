FactoryBot.define do
  factory :rating do
    post_id { rand(1..3000) }
    rating_value { rand(1..5)}
  end
end
