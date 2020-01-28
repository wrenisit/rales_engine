FactoryBot.define do
  factory :invoice, class: Invoice do
    quantity      { 2345}
    unit_price   { 334455}
    association :customer, factory: :customer
    association :merchant, factory: :merchant
  end
end
