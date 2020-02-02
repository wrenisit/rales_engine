require "rails_helper"

RSpec.describe "Invoices" do
  it "has invoice index" do
    create_list(:invoice, 3)
    get '/api/v1/invoices'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
  end

  it "has invoice show" do
    create_list(:invoice, 3)
    invoice1 = Invoice.last
    get "/api/v1/invoices/#{invoice1.id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq("#{invoice1.id}")
  end

  it "has invoice find by id" do
    create_list(:invoice, 3)
    invoice1 = Invoice.last
    get "/api/v1/invoices/find?id=#{invoice1.id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq("#{invoice1.id}")
  end

  it "has invoice find by id" do
    create_list(:invoice, 3)
    merchant1 = Merchant.create(name: "This")
    create(:invoice, merchant: merchant1)
    invoice1 = Invoice.last
    get "/api/v1/invoices/find?merchant_id=#{invoice1.merchant_id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)["data"]["attributes"]
    expect(invoice["merchant_id"]).to eq(invoice1.merchant_id)
  end

  it "has find all invoices by merchant_id" do
    merchant1 = Merchant.create(name: "That")

    create(:invoice, merchant: merchant1)
    create(:invoice, merchant: merchant1)
    create(:invoice, merchant: merchant1)
    invoice1 = Invoice.last
    merchant3 = Merchant.create(name: "This")
    invoice2 = create(:invoice, merchant: merchant3)
    get "/api/v1/invoices/find_all?merchant_id=#{invoice1.merchant_id}"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
  end

end
