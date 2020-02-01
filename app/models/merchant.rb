class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.revenue_by_date(date_needed)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select(:name, "invoices.created_at as date, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:name, "date").where(transactions: {result: "success"})
    .merge(Invoice.day(date_needed))
  end

  def self.find_records_by(param, value)
    Merchant.where("#{param} = ?", value)
  end
end
