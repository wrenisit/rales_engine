class Customer < ApplicationRecord

  validates_presence_of :first_name, :last_name
  has_many :invoices
  default_scope { order("id asc")}


  def self.find_record(param)
    Customer.where(param).first
  end

  def self.find_all_by(param)
    Customer.where(param)
  end
end
