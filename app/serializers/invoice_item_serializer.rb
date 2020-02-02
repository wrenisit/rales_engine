class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :item
  belongs_to :invoice
  attributes :id, :item_id, :invoice_id, :quantity

  attributes :unit_price do |item|
    (item.unit_price.to_f/100).to_s
  end

end
