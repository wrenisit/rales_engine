require "rails_helper"

RSpec.describe "Merchant Index" do
  it "has merchant index" do
    create_list(:merchant, 3)
    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)["data"]
    expect(merchants.count).to eq(3)
  end

  it "shows one merchant" do
    create_list(:merchant, 5)
    merchant_1 = Merchant.last
    get "/api/v1/merchants/#{merchant_1.id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)["data"]["attributes"]
    expect(merchant["name"]).to eq(merchant_1.name)
  end

  it "shows one merchant's items" do

    merchant_1 = create(:merchant1)
    create(:item, merchant: merchant_1)
    create(:item, merchant: merchant_1)
    create(:item, merchant: merchant_1)
    create(:item, merchant: merchant_1)
    create(:item, merchant: merchant_1)
    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body)["data"]
    expect(items.count).to eq(5)

    merchant_2 = create(:merchant)
    create(:item, merchant: merchant_2)
    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body)["data"]
    expect(items.count).to eq(5)
  end
end
