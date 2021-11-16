require "rails_helper"

RSpec.describe Discount, type: :model do

  describe "relationships" do
    it {should belong_to :merchant}
  end

  describe "instance methods" do

    before(:each) do
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")
      @discount = @merchant.discounts.create!(discount_percentage: 20, threshhold_quantity: 10)
    end

    it "#params_integer" do
      a = 38
      b = 94
      expect(@discount.params_integer(a, b)).to be true

      c = "string"
      expect(@discount.params_integer(a, c)).to be false
    end

    it "#params_percent_too_big" do
      a = -1
      b = 50
      c = 101

      expect(@discount.params_percent_too_big_or_small(a)).to be true
      expect(@discount.params_percent_too_big_or_small(b)).to be false
      expect(@discount.params_percent_too_big_or_small(c)).to be true
    end
  end
end
