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

  it "shows transactions for one invoice" do
    merchant1 = Merchant.create(name: "That")
    create(:invoice, merchant: merchant1)
    invoice1 = Invoice.last
    transaction1 = Transaction.create(invoice: invoice1, credit_card_number: "12345")
    transaction2 = Transaction.create(invoice: invoice1, credit_card_number: "12345")
    transaction3 = Transaction.create(invoice: invoice1, credit_card_number: "12345")

    get "/api/v1/invoices/#{invoice1.id}/transactions"

    expect(response).to be_successful
    transactions = JSON.parse(response.body)["data"]
    expect(transactions.count).to eq(3)
  end

  it "shows items in an invoice" do
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    invoice_item2 = InvoiceItem.create(item: item2, invoice: invoice1, quantity: 333, unit_price: "4444")
    get "/api/v1/invoices/#{invoice1.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body)["data"]
    expect(items.count).to eq(2)
  end

  it "has invoice_items index for invoice" do
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1)
    item1 = create(:item)
    item2 = create(:item)
    invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    invoice_item2 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 333, unit_price: "4444")
    get "/api/v1/invoices/#{invoice1.id}/invoice_items"

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)["data"]
    expect(invoice_items.count).to eq(2)
  end

  it "shows one invoice's customer" do
    create_list(:customer, 2)
    customer_1 = Customer.last
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1, customer: customer_1)
    get "/api/v1/invoices/#{invoice1.id}/customer"

    expect(response).to be_successful
    customer = JSON.parse(response.body)["data"]["attributes"]
    expect(customer["first_name"]).to eq(customer_1.first_name)
  end

  it "shows one invoice's merchant" do
    create_list(:customer, 2)
    customer_1 = Customer.last
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1, customer: customer_1)
    get "/api/v1/invoices/#{invoice1.id}/merchant"

    expect(response).to be_successful
    customer = JSON.parse(response.body)["data"]["attributes"]
    expect(customer["name"]).to eq(merchant1.name)
  end
end
