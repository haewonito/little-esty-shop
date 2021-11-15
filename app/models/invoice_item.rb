class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [ :pending, :packaged, :shipped ]

  def self.total_revenue(invoice)
    where(invoice_id: invoice.id).sum(:unit_price)
  end

  def find_discounts_applied
    Item.joins(merchant: [:discounts])
    .select("discounts.id as discount_id")
    .where("discounts.threshhold_quantity <= ?", quantity)
    .order("discounts.discount_percentage")
    .last
  end

  
end
