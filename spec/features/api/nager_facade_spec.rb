require 'rails_helper'

RSpec.describe NagerFacade do
  it 'constructs nagerholiday objects' do
    mock_response = '[
          {"date":"2021-11-25","localName":"Thanksgiving Day","name":"Thanksgiving Day","countryCode":"US","fixed":false,"global":true,"counties":null,"launchYear":1863,"types":["Public"]},
          {"date":"2021-12-24","localName":"Christmas Day","name":"Christmas Day","countryCode":"US","fixed":false,"global":true,"counties":null,"launchYear":null,"types":["Public"]},
          {"date":"2022-01-17","localName":"Martin Luther King, Jr. Day","name":"Martin Luther King, Jr. Day","countryCode":"US","fixed":false,"global":true,"counties":null,"launchYear":null,"types":["Public"]}
          ]'

    facade = NagerFacade.new(mock_response)
    expect(facade.first).to be_a NagerHoliday
    expect(GithubFacade.first.name).to eq("Thanksgiving")
  end
end
