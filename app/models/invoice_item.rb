class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [ :pending, :packaged, :shipped ]

  def self.total_revenue(invoice)
    where(invoice_id: invoice.id).sum(:unit_price)
  end

  def find_discounts_applied
    joins(item: [merchant: [:discounts]])
    .where("discounts.threshhold_quantity <= invoice_items.quantity")
    .group("invoice_items.id")
    .order("discounts.discount_percentage")
    .last
  end
  
end
