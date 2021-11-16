class Discount < ApplicationRecord
  belongs_to :merchant

  # def params_integer(percent, threshhold)
  #   if percent.to_i.integer? and threshhold.to_i.integer?
  #     true
  #   else
  #     false
  #   end
  # end

  def params_percent_too_big_or_small(percent)
    if percent.to_i < 0 or percent.to_i > 100
      true
    else
      false
    end
  end


end
