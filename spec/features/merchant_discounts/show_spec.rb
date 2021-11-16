require "rails_helper"

RSpec.describe "merchant discount show page", type: :feature do
  describe "as a merchant" do
    before(:each) do
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @discount1 = @merchant.discounts.create!(discount_percentage: 20, threshhold_quantity: 10)

      visit "/merchants/#{@merchant.id}/discounts/#{@discount1.id}"
    end

    it "I see the discount's quantity and discount percentage" do
      expect(page).to have_content("Discount #{@discount1.id} --- Quantity: #{@discount1.threshhold_quantity} units, Discount: #{@discount1.discount_percentage}%")
    end

    it "I can edit the discount and it will give me a flash message when successful" do
      click_on "Edit This Discount"

      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit")

      fill_in "Discount percentage", with: "30"
      fill_in "Threshhold quantity", with: "40"
      click_on "Update Discount"

      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}")
      expect(page).to have_content("Discount #{@discount1.id} --- Quantity: 40 units, Discount: 30%")
      expect(page).to have_content("Discount updated successfully")
    end

    it "flashes error message if percentage too big or too small" do
      click_on "Edit This Discount"

      fill_in "Discount percentage", with: "300"
      fill_in "Threshhold quantity", with: "40"
      click_on "Update Discount"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit")
      expect(page).to have_content("Discount percent cannot be less than 0 or more than hundred. Try again")

      fill_in "Discount percentage", with: "-10"
      fill_in "Threshhold quantity", with: "40"
      click_on "Update Discount"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit")
      expect(page).to have_content("Discount percent cannot be less than 0 or more than hundred. Try again")
    end

    xit "flashes error message if either input is not an integer" do
      click_on "Edit This Discount"

      fill_in "Discount percentage", with: "string1"
      fill_in "Threshhold quantity", with: "40"
      click_on "Update Discount"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit")
      expect(page).to have_content("Discount percent cannot be less than 0 or more than hundred. Try again")

      fill_in "Discount percentage", with: "50"
      fill_in "Threshhold quantity", with: "string2"
      click_on "Update Discount"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit")
      expect(page).to have_content("Discount percent cannot be less than 0 or more than hundred. Try again")
    end
  end
end
