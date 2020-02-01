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
end
