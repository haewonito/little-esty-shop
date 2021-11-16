require 'rails_helper'

RSpec.describe NagerService do
  it 'returns data upcoming US holidays' do
    mock_response = '[
          {"date":"2021-11-25","localName":"Thanksgiving Day","name":"Thanksgiving Day","countryCode":"US","fixed":false,"global":true,"counties":null,"launchYear":1863,"types":["Public"]},
          {"date":"2021-12-24","localName":"Christmas Day","name":"Christmas Day","countryCode":"US","fixed":false,"global":true,"counties":null,"launchYear":null,"types":["Public"]},
          {"date":"2022-01-17","localName":"Martin Luther King, Jr. Day","name":"Martin Luther King, Jr. Day","countryCode":"US","fixed":false,"global":true,"counties":null,"launchYear":null,"types":["Public"]}
          ]'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    json = NagerService.holidays_us

    expect(json).to be_an Array
    expect(json[0]).to have_key :date
    expect(json[1]).to have_key :name
  end
end
