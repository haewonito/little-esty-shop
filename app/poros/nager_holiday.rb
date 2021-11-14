#this is the class that defines holiday object

class NagerHoliday
  attr_reader :date
              :name

  def initialize(data)
    @date = data[:date]
    @name = data[:name]
  end
end
