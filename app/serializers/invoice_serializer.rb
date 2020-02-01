class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  has_many :invoice_items
  belongs_to :merchant
  belongs_to :customer
  attributes :id, :merchant_id, :customer_id, :status

end
