require 'rails_helper'

RSpec.describe HolidayFacade do
  it 'constructs nagerholiday objects' do
    facade = HolidayFacade.holidays
    expect(facade.first).to be_a NagerHoliday
    expect(facade.first.name).to eq("Thanksgiving Day")
  end
end

#second expectation will have to change when time passes.
#didn't know how to make dynamic
