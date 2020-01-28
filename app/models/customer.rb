class Customer < ApplicationRecord

  validates_presence_of :first_name, :last_name
  
  has_many :transactions
  has_many :invoices

end
