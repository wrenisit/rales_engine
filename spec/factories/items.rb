FactoryBot.define do
  factory :item, class: Item do
    sequence(:name)   {|n| "#{Faker::Commerce.product_name} #{n}"}
    description       {Faker::Lorem.sentence}
    unit_price        {rand(1..100)}
    association       :merchant, factory: :merchant
  end
end
