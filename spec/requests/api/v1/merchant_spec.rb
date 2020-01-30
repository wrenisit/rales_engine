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

  it "can send the list of merchants with revenue by day" do
    merchant_1 = create(:merchant1)
    items = [create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1),
    create(:item, merchant: merchant_1)]
    invoice1 = create(:invoice, created_at: "2012-03-25 09:54:09 UTC")
    items.each do |item|
      InvoiceItem.create(invoice: invoice1, item: item, quantity: 7, unit_price: 10, created_at: "2012-05-09 09:54:09 UTC")
    end
    create(:transaction, invoice: invoice1)
    merchant_2 = create(:merchant)
    items_2 = [create(:item, merchant: merchant_2),
      create(:item, merchant: merchant_2)]
    invoice2 = create(:invoice, created_at: "2012-05-09 09:54:09 UTC")
    items_2.each do |item|
      InvoiceItem.create(invoice: invoice2, item: item, quantity: 7, unit_price: 10, created_at: "2012-05-09 09:54:09 UTC")
    end
    create(:transaction, invoice: invoice2)

    merchant_3 = create(:merchant)
    invoice_3 = create(:invoice, created_at: "2012-03-25 09:54:09 UTC")
    item_3 = create(:item, merchant: merchant_3)
    InvoiceItem.create(invoice: invoice_3, item: item_3, quantity: 7, unit_price: 10, created_at: "2012-03-25 09:54:09 UTC")
    create(:transaction, invoice: invoice_3)

    date = "2012-03-25"
    get "/api/v1/merchants/revenue?date=#{date}"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)["data"]
    expect(merchants.count).to eq(2)

    date2 = "2012-05-09"
    get "/api/v1/merchants/revenue?date=#{date2}"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)["data"]
    expect(merchants.count).to eq(1)
  end

  it "shows one merchant find by id" do
    create_list(:merchant, 5)
    merchant1 = Merchant.last
    num = merchant1.id.to_s
    get "/api/v1/merchants/find?id=#{num}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)["data"]["attributes"]
    expect(merchant["name"]).to eq(merchant1.name)
  end

  it "shows one merchant find by name" do
    create_list(:merchant, 5)
    merchant1 = Merchant.last
    get "/api/v1/merchants/find?name=#{merchant1.name}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)["data"]["attributes"]
    expect(merchant["name"]).to eq(merchant1.name)
  end

  it "shows all merchants find by name" do
    create_list(:merchant, 5)
    merchant_1 = create(:merchant1)
    merchant_2 = create(:merchant1)
    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)["data"]
    expect(merchants[0]["attributes"]["name"]).to eq(merchant_1.name)
    expect(merchants.count).to eq(2)
  end

  it "shows all merchants find_all by id" do
    create_list(:merchant, 5)
    merchant1 = Merchant.last
    get "/api/v1/merchants/find_all?id=#{merchant1.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]
    expect(merchant[0]["attributes"]["id"]).to eq(merchant1.id)
  end
  # it "shows all merchants find by created_at" do
  #   create_list(:merchant, 5)
  #   merchant_1 = create(:merchant1, created_at: "2012-03-25 09:54:09 UTC")
  #   merchant_2 = create(:merchant1, created_at: "2012-03-25 09:54:09 UTC")
  #   get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"
  #
  #   expect(response).to be_successful
  #   merchants = JSON.parse(response.body)["data"]
  #   expect(merchants[0]["attributes"]["created_at"]).to eq(merchant_1.created_at)
  #   expect(merchants.count).to eq(2)
  # end

  # it "shows one merchant find by created_at" do
  #   create_list(:merchant, 5)
  #   merchant1 = create(:merchant1, created_at: "2012-03-25 09:54:09 UTC")
  #   time = "2012-03-25T09:54:09.000Z"
  #   binding.pry
  #   get "/api/v1/merchants/find?created_at=#{time}"
  #
  #   expect(response).to be_successful
  #   merchant = JSON.parse(response.body)["data"]["attributes"]
  #   expect(merchant["created_at"]).to eq(time)
  # end
end
