FactoryBot.define do
  factory :invoice, class: Invoice do
    status   { "thing" }
    association :customer, factory: :customer1
    association :merchant, factory: :merchant
  end
end
