class NagerService
  def holidays_us
    get_url("/NextPublicHolidays/US")
  end

  def get_url(url)
    response = Faraday.get("https://date.nager.at/api/v2#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
