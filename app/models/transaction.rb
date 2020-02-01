class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  belongs_to :invoice
  default_scope { order("id asc")}


  def self.find_record(param)
    Transaction.where(param).first
  end

  def self.find_all_by(param)
    Transaction.where(param)
  end
end
