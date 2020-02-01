FactoryBot.define do
  factory :invoice, class: Invoice do
    status   { "success" }
    association :customer, factory: :customer1
    association :merchant, factory: :merchant1
  end
end
