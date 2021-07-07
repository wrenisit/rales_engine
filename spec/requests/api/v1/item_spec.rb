require "rails_helper"

RSpec.describe "Items" do
  it "has items index" do
    create_list(:item, 3)
    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)["data"]
    expect(items.count).to eq(3)
  end

  it "has item show" do
    create_list(:item, 3)
    item1 = create(:item)
    get "/api/v1/items/#{item1.id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]["attributes"]
    expect(item["id"]).to eq(item1.id)
  end

  it "finds by id" do
    create_list(:item, 3)
    item1 = create(:item)
    get "/api/v1/items/find?id=#{item1.id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]["attributes"]
    expect(item["id"]).to eq(item1.id)
  end

  it "finds by name" do
    create_list(:item, 3)
    item1 = create(:item)
    get "/api/v1/items/find?name=#{item1.name}"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]["attributes"]
    expect(item["name"]).to eq(item1.name)
  end

  it "finds by description" do
    create_list(:item, 3)
    item1 = create(:item)
    get "/api/v1/items/find?description=#{item1.description}"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]["attributes"]
    expect(item["description"]).to eq(item1.description)
  end

  it "has invoice_items index for item" do
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1)
    item1 = create(:item)
    item2 = create(:item)
    invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    invoice_item2 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    invoice_item3 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    invoice_item4 = InvoiceItem.create(item: item2, invoice: invoice1, quantity: 333, unit_price: "4444")
    get "/api/v1/items/#{item1.id}/invoice_items"

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)["data"]
    expect(invoice_items.count).to eq(3)
  end

  it "shows a merchant for an item" do
    merchant1 = Merchant.create(name: "This")
    item1 = create(:item, merchant: merchant1)
    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)["data"]
    expect(merchant["id"]).to eq("#{merchant1.id}")
  end
end
