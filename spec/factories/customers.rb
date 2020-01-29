FactoryBot.define do
  factory :customer, class: Customer do
    first_name      {Faker::FunnyName.first_name}
    last_name      {Faker::FunnyName.last_name}
  end

  factory :customer1, class: Customer do
    first_name      { "Polly" }
    last_name      { "Wog" }
  end
end
