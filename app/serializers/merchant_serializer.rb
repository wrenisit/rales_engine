class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  has_many :invoices
  has_many (:invoice_items), through: (:invoices)
  attributes :id, :name
end
