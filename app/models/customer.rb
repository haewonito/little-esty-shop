class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers
    customers = joins(invoices: :transactions)
                .where(transactions: {result: 'success'})
                .limit(5)
                .group("(first_name || ' ' || last_name)")
                .count
    result = customers.sort_by { |name, count| count }.reverse
  end

  def self.find_by_invoice_id(invoice_id)
    joins(:invoices)
    .where(invoices: { id: invoice_id})
    .select("customers.*").first
  end
end
