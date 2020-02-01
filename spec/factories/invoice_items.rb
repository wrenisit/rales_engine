FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    quantity      { 2345}
    unit_price   { 334455}
    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end
