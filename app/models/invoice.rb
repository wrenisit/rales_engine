class Invoice < ApplicationRecord
  validates_presence_of :status
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant
  default_scope { order("id asc")}
  
  scope :day, ->(date) { where(date_helper(date))}

  def self.date_helper(date)
    start = Time.zone.parse(date)
    finish = start + 1.days
    {created_at: start..finish}
  end

  def self.find_record(param)
    Invoice.where(param).first
  end

  def self.find_all_by(param)
    Invoice.where(param)
  end
end
