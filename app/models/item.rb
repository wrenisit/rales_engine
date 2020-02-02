class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order("id asc")}

  def self.find_record(param)
    if param.keys == ["unit_price"]
      new_param = (param["unit_price"].to_f * 100).round
      Item.where(unit_price: new_param).first
    else
      Item.where(param).first
    end
  end

  def self.find_all_by(param)
    if param.keys == ["unit_price"]
      new_param = (param["unit_price"].to_f * 100).to_i
      Item.where(unit_price: new_param)
    else
      Item.where(param)
    end
  end
end
