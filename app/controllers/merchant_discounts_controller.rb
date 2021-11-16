class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts

    @holidays = HolidayFacade.holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.discounts.create(threshhold_quantity: params[:threshhold_quantity], discount_percentage: params[:discount_percentage])
    redirect_to "/merchants/#{merchant.id}/discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:discount_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:discount_id])
    
    if discount.params_percent_too_big_or_small(params[:discount_percentage])
      flash[:too_big] = "Discount percent cannot be less than 0 or more than hundred. Try again"
      redirect_to "/merchants/#{merchant.id}/discounts/#{discount.id}/edit"

    elsif discount.params_integer(params[:discount_percentage], params[:threshhold_quantity]) == false
    flash[:not_integer] = "Both numbers need to be integers. Try again"
    redirect_to "/merchants/#{merchant.id}/discounts/#{discount.id}/edit"

    else
      discount.update(discount_percentage: params[:discount_percentage], threshhold_quantity: params[:threshhold_quantity])
      redirect_to "/merchants/#{merchant.id}/discounts/#{discount.id}"
      flash[:update_success] = 'Discount updated successfully'
    end
  end

  def destroy
    discount = Discount.find(params[:discount_id])
    discount.destroy

    redirect_to "/merchants/#{params[:merchant_id]}/discounts"
  end
end
