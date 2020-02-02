class ItemSerializer
  include FastJsonapi::ObjectSerializer
  has_many :invoice_items
  belongs_to :merchant
  attributes :id, :merchant_id, :name, :description

  attributes :unit_price do |item|
    (item.unit_price.to_f/100).to_s
  end
end
