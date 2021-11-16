class Discount < ApplicationRecord
  belongs_to :merchant

  def params_integer(percent, threshhold)
    percent[0].class == Integer && threshhold[0].class == Integer
  end

  def params_percent_too_big_or_small(percent)
    percent.to_i < 0 || percent.to_i > 100
  end
end
