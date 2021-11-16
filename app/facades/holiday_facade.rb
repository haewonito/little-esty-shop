class HolidayFacade
  def self.holidays
    holidays = NagerService.call_api("/api/v2/NextPublicHolidays/US")

    holidays.map do |holiday|
      NagerHoliday.new(holiday)
    end
  end
end
