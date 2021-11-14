class NagerService
  class << self
    def call_api(path)
      response = connection.get(path) #in case of key, ".view...etc"
      parsed_data(response)
    end

    private #private methods don't get tested and connections need to be private
    def connection
      Faraday.new("https://date.nager.at")
    end

    def parsed_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  # def self.holidays_us
  #   get_url("/NextPublicHolidays/US")
  # end
  #
  # def self.get_url(url)
  #   response = Faraday.get("https://date.nager.at/api/v2#{url}")
  #   parsed = JSON.parse(response.body, symbolize_names: true)
  # end
  end
end


# Us2
# As a merchant
# When I visit the discounts index page
# I see a section with a header of "Upcoming Holidays"
# In this section the name and date of the next 3 upcoming US
#holidays are listed.
#
# Use the Next Public Holidays Endpoint in the
# [Nager.Date API](https://date.nager.at/swagger/index.html)
