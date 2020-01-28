FactoryBot.define do
  factory :merchant, class: Merchant do
    name      {Faker::FunnyName.name}
  end

  factory :merchant1, class: Merchant do
    name      { "Monkey Business"}
  end
end
