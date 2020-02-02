FactoryBot.define do
  factory :customer, class: Customer do
    first_name      { "Bob" }
    last_name      { "Ross" }
  end

  factory :customer1, class: Customer do
    first_name      { "Polly" }
    last_name      { "Wog" }
  end
end
