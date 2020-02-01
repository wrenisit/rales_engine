class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price

  belongs_to :item
  belongs_to :invoice
  default_scope { order("id asc")}

  def self.find_record(param)
    if param.keys == ["unit_price"]
      new_param = (param["unit_price"].to_f * 100).round
      InvoiceItem.where(unit_price: new_param).first
    else
      InvoiceItem.where(param).first
    end
  end

  def self.find_all_by(param)
    if param.keys == ["unit_price"]
      new_param = (param["unit_price"].to_f * 100).round
      InvoiceItem.where(unit_price: new_param)
    else
      InvoiceItem.where(param)
    end
  end
end
