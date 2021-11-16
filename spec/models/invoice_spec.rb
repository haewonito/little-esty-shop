require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
  end

  describe '::pending_invoices' do
    it 'returns an array of pending invoices' do
      merchant1 = Merchant.create!(name: 'Bob Burger')
      customer1 = Customer.create!(first_name: "Bob", last_name: "Dylan")
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 'in progress')
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 'completed')
      item1 = Item.create!(name: 'book', description: 'good book', unit_price: 12, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'spatula', description: 'good spatula', unit_price: 8, merchant_id: merchant1.id)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 24, status: 'pending')
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 16, status: 'shipped')


      expect(Invoice.pending_invoices).to eq([invoice1])
    end
  end

  describe '#total_revenue' do
    it 'can return the total revenue for an invoice' do
      merchant1 = Merchant.create!(name: 'Bob Burger')
      customer1 = Customer.create!(first_name: "Bob", last_name: "Dylan")
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 'in progress')
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 'completed')
      item1 = Item.create!(name: 'book', description: 'good book', unit_price: 12, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'spatula', description: 'good spatula', unit_price: 8, merchant_id: merchant1.id)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 24, status: 'pending')
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 16, status: 'shipped')

      expect(invoice1.total_revenue).to eq(48)
      expect(invoice2.total_revenue).to eq(32)
    end
  end

  describe '#total_discount_revenue' do
    it 'can return total_discount_revenue' do
      merchant = Merchant.create(name: "Bob's Burger")

      item_1 = merchant.items.create(name: 'Burger', description: 'its on a string', unit_price: 1000)
      item_2 = merchant.items.create(name: 'Shake', description: 'dried grape', unit_price: 100)

      customer = Customer.create(first_name: 'Teddy', last_name: 'Lastname')

      invoice_1 = customer.invoices.create(status: 2)
      invoice_2 = customer.invoices.create(status: 2)

      invoice_item_1 = invoice_1.invoice_items.create(item_id: item_1.id, quantity: 3, unit_price: 1000, status: 1)
      invoice_item_2 = invoice_1.invoice_items.create(item_id: item_2.id, quantity: 1, unit_price: 100, status: 1)
      invoice_item_3 = invoice_1.invoice_items.create(item_id: item_1.id, quantity: 10, unit_price: 1000, status: 1)
      invoice_item_4 = invoice_1.invoice_items.create(item_id: item_2.id, quantity: 20, unit_price: 100, status: 1)

      discount1 = merchant.discounts.create!(threshhold_quantity: 10, discount_percentage: 20)
      discount3 = merchant.discounts.create!(threshhold_quantity: 8, discount_percentage: 30)


      expect(invoice_1.total_discount_revenue).to eq(11500)
    end
  end
end
