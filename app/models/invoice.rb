class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions

  has_many :invoice_items


  enum status: [ "cancelled", "in progress", "completed" ]

  def self.pending_invoices
    joins(:invoice_items).where.not(invoice_items: {status: 'shipped'}).order(:created_at).uniq
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discount_revenue


    discount = invoice_items.joins(item: [merchant: [:discounts]])
                 .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (discounts.discount_percentage / 100.00)) as total_discount")
                 .where("discounts.threshhold_quantity <= invoice_items.quantity")
                 .group("invoice_items.id")
                 .sum(&:"total_discount")

    total_including_discount = total_revenue - discount

  end

end
