require "rails_helper"

RSpec.describe "InvoiceItems" do
  it "has invoice_items index" do
    create_list(:invoice_item, 3)
    get '/api/v1/invoice_items'

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)["data"]
    expect(invoice_items.count).to eq(3)
  end

  it "has invoice_item show" do
    create_list(:invoice_item, 3)
    invoice_item1 = InvoiceItem.last
    get "/api/v1/invoice_items/#{invoice_item1.id}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)["data"]
    expect(invoice_item["id"]).to eq("#{invoice_item1.id}")
  end

  it "has invoice show for invoice_items" do
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1)
    item1 = create(:item)
    item2 = create(:item)
    invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    invoice_item2 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    get "/api/v1/invoice_items/#{invoice_item1.id}/invoice"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)["data"]["attributes"]
    expect(invoice["id"]).to eq(invoice1.id)
  end

  it "has invoice show for invoice_items" do
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1)
    item1 = create(:item)
    item2 = create(:item)
    invoice_item1 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    invoice_item2 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    get "/api/v1/invoice_items/#{invoice_item1.id}/item"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]["attributes"]
    expect(item["id"]).to eq(item1.id)
  end
end
