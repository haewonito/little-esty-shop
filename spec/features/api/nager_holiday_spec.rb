require 'rails_helper'

RSpec.describe NagerHoliday do
  it 'exists' do
    holiday = NagerHoliday.new({"date":"2021-11-25","name":"Thanksgiving Day"})

    expect(holiday).to be_an_instance_of NagerHoliday
  end

  it 'gets the names of the users' do
    holiday = NagerHoliday.new({"date":"2021-11-25","name":"Thanksgiving Day"})

    expect(holiday.name).to eq("Thanksgiving Day")
    expect(holiday.date).to eq("2021-11-25")
  end
end
