class HolidayFacade
  def holidays
    service.holidays_us.map do |data|
      NagerHoliday.new(data)
    end
  end

  def service
    NagerService.new
  end
end
