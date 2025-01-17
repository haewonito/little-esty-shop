require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  it 'has a link to create a new merchant' do
    visit admin_merchants_path

    click_link 'Create Merchant'

    expect(current_path).to eq(admin_merchants_new_path)

    fill_in :name, with: 'Bob'
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Name: Bob')
    expect(page).to have_content('Status: Disabled')
  end

  it 'has a button to change the status of a merchant' do
    merchant1 = Merchant.create!(name: 'Alan Apple')
    merchant2 = Merchant.create!(name: 'Bob Burger')

    visit admin_merchants_path

    within "#id-#{merchant1.id}" do
      expect(page).to have_button("Enable/Disable")
    end

    within "#id-#{merchant2.id}" do
      expect(page).to have_button("Enable/Disable")
    end
  end

  it 'when the button is clicked it changes the status of the merchant' do
    merchant1 = Merchant.create!(name: 'Alan Apple', status: 'Enabled')

    visit admin_merchants_path

    within "#id-#{merchant1.id}" do
      click_button 'Enable/Disable'
      expect(page).to have_content("Status: Disabled")
    end
  end

  it 'displays the top 5 merchants based on revenue generated' do
    merchant1 = Merchant.create!(name: "Bob", status: "Enabled")
    merchant2 = Merchant.create!(name: "Kevin")
    merchant3 = Merchant.create!(name: "Zach")

    item1 = merchant1.items.create!(name: 'Mug', description: 'You can drink with it', unit_price: 5)
    item2 = merchant2.items.create!(name: 'GPU', description: 'Its too expensive', unit_price: 1500)
    item3 = merchant3.items.create!(name: 'Compressed Air', description: 'Its compressed', unit_price: 2)

    customer_1 = Customer.create!(first_name: 'Jen', last_name: 'R')
    customer_2 = Customer.create!(first_name: 'Micha', last_name: 'B')
    customer_3 = Customer.create!(first_name: 'Richard', last_name: 'A')

    invoice_1 = customer_1.invoices.create!(status: 2)
    invoice_2 = customer_2.invoices.create!(status: 2)
    invoice_3 = customer_3.invoices.create!(status: 1)

    invoice_item_1 = invoice_1.invoice_items.create!(item_id: item1.id, quantity: 2, unit_price: 5, status: 2)
    invoice_item_2 = invoice_2.invoice_items.create!(item_id: item2.id, quantity: 2, unit_price: 1500, status: 2)
    invoice_item_3 = invoice_3.invoice_items.create!(item_id: item3.id, quantity: 2, unit_price: 2, status: 2)
    invoice_item_4 = invoice_1.invoice_items.create!(item_id: item1.id, quantity: 2, unit_price: 5, status: 2)
    invoice_item_5 = invoice_2.invoice_items.create!(item_id: item2.id, quantity: 2, unit_price: 1500, status: 2)
    invoice_item_6 = invoice_3.invoice_items.create!(item_id: item3.id, quantity: 2, unit_price: 2, status: 2)

    transaction_1 = invoice_1.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_2 = invoice_2.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_3 = invoice_3.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')

    visit "/admin/merchants"

    expect(page).to have_content('Top 5 Merchants:')
    expect('Kevin - $60.00').to appear_before('Bob - $0.20')
    expect(page).to_not have_content('Zach - $0.10')
  end

  it 'shows the top revenue day per merchant' do
    merchant1 = Merchant.create!(name: "Bob", status: "Enabled")
    merchant2 = Merchant.create!(name: "Kevin")
    merchant3 = Merchant.create!(name: "Zach")

    item1 = merchant1.items.create!(name: 'Mug', description: 'You can drink with it', unit_price: 5)
    item2 = merchant2.items.create!(name: 'GPU', description: 'Its too expensive', unit_price: 1500)
    item3 = merchant3.items.create!(name: 'Compressed Air', description: 'Its compressed', unit_price: 2)

    customer_1 = Customer.create!(first_name: 'Jen', last_name: 'R')
    customer_2 = Customer.create!(first_name: 'Micha', last_name: 'B')
    customer_3 = Customer.create!(first_name: 'Richard', last_name: 'A')

    invoice_1 = customer_1.invoices.create!(status: 2, created_at: "2021-11-11")
    invoice_2 = customer_2.invoices.create!(status: 2, created_at: "2021-11-11")
    invoice_3 = customer_3.invoices.create!(status: 2, created_at: "2021-11-11")
    invoice_4 = customer_1.invoices.create!(status: 2, created_at: "2019-03-06")
    invoice_5 = customer_2.invoices.create!(status: 2, created_at: "2019-03-06")
    invoice_6 = customer_3.invoices.create!(status: 2, created_at: "2019-03-06")

    invoice_item_1 = invoice_1.invoice_items.create!(item_id: item1.id, quantity: 2, unit_price: 5, status: 2)
    invoice_item_2 = invoice_2.invoice_items.create!(item_id: item2.id, quantity: 10, unit_price: 1500, status: 2)
    invoice_item_3 = invoice_3.invoice_items.create!(item_id: item3.id, quantity: 2, unit_price: 2, status: 2)
    invoice_item_4 = invoice_4.invoice_items.create!(item_id: item1.id, quantity: 10, unit_price: 5, status: 2)
    invoice_item_5 = invoice_5.invoice_items.create!(item_id: item2.id, quantity: 8, unit_price: 1500, status: 2)
    invoice_item_6 = invoice_6.invoice_items.create!(item_id: item3.id, quantity: 6, unit_price: 2, status: 2)

    transaction_1 = invoice_1.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_2 = invoice_2.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_3 = invoice_3.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_4 = invoice_4.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_5 = invoice_5.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_6 = invoice_6.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')

    visit "/admin/merchants"

    expect(page).to have_content("Top selling date for #{merchant2.name} was: #{invoice_2.created_at.strftime("%A, %B %-d, %Y")}")
    expect(page).to have_content("Top selling date for #{merchant1.name} was: #{invoice_4.created_at.strftime("%A, %B %-d, %Y")}")
    expect(page).to have_content("Top selling date for #{merchant3.name} was: #{invoice_6.created_at.strftime("%A, %B %-d, %Y")}")
    visit admin_merchants_path

    expect(page).to have_content('Top 5 Merchants:')
    expect('Kevin - $270.00').to appear_before('Bob - $0.60')
    expect('Bob - $0.60').to appear_before('Zach - $0.16')
  end

  it 'has sections for enabled and disabled merchants' do
    merchant1 = Merchant.create!(name: 'Jimmy Pesto')
    merchant1 = Merchant.create!(name: 'Linda Belcher')
    merchant1 = Merchant.create!(name: 'Louis Belcher')

    visit '/admin/merchants'

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")
  end
end
