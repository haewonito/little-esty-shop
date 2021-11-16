require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'class methods' do
    it '::total_revenue - returns the total expected revenue from a given invoice' do
      customer = Customer.create!(first_name: 'Bob', last_name: 'Dylan')
      merchant = Merchant.create!(name: 'Jen')
      invoice = Invoice.create!(customer_id: customer.id, status: 'completed')
      item1 = Item.create!(name: 'Pumpkin', description: 'Orange', unit_price: 3, merchant_id: merchant.id)
      item2 = Item.create!(name: 'Pillow', description: 'Soft', unit_price: 20, merchant_id: merchant.id)
      invoice_item = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice.id, quantity: 10, unit_price: 30, status: 'shipped')
      invoice_item = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice.id, quantity: 2, unit_price: 40, status: 'shipped')

      expect(InvoiceItem.total_revenue(invoice)).to eq(70)
    end
  end

  describe 'instance methods' do
    it "find_discounts_applied" do
      customer = Customer.create!(first_name: 'Bob', last_name: 'Dylan')
      merchant = Merchant.create!(name: 'Jen')
      invoice = Invoice.create!(customer_id: customer.id, status: 'completed')

      item1 = Item.create!(name: 'Pumpkin', description: 'Orange', unit_price: 3, merchant_id: merchant.id)
      item2 = Item.create!(name: 'Pillow', description: 'Soft', unit_price: 20, merchant_id: merchant.id)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice.id, quantity: 10, unit_price: 30, status: 'shipped')
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice.id, quantity: 2, unit_price: 40, status: 'shipped')

      discount1 = merchant.discounts.create!(threshhold_quantity: 10, discount_percentage: 20)
      discount2 = merchant.discounts.create!(threshhold_quantity: 8, discount_percentage: 15)
      discount3 = merchant.discounts.create!(threshhold_quantity: 5, discount_percentage: 10)

      expect(invoice_item1.find_discounts_applied.discount_id).to eq(discount1.id)
      expect(invoice_item2.find_discounts_applied).to be_nil
    end
  end
end
