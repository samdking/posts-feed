# This will guess the User class
FactoryBot.define do
  factory :like do
    post_id { rand(10_000) }
    anonymous_user
  end

  factory :anonymous_user do
  end

  factory :post, class: OpenStruct do
    id { rand(10_000) }
    sequence(:title) { |n| "Post ##{n}" }
    reactions { { 'likes' => 0 } }
    value { { 'price' => 0 } }
    location { { 'town' => 'Brighton', 'country' => 'United Kingdom' } }
  end
end
