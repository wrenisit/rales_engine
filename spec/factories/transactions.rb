FactoryBot.define do
  factory :transaction, class: Transaction do
    result    { "success"}
    credit_card_number { 3434343 }
    association :invoice, factory: :invoice
  end
end
