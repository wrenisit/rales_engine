require "rails_helper"

RSpec.describe "Customer Index" do
  it "has customer index" do
    create_list(:customer, 3)
    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)["data"]
    expect(customers.count).to eq(3)
  end

  it "shows one customer" do
    create_list(:customer, 5)
    customer_1 = Customer.last
    get "/api/v1/customers/#{customer_1.id}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)["data"]["attributes"]
    expect(customer["first_name"]).to eq(customer_1.first_name)
  end

  it "shows one customer's invoices" do
    create_list(:customer, 2)
    customer_1 = Customer.last
    merchant1 = Merchant.create(name: "This")
    invoice1 = create(:invoice, merchant: merchant1, customer: customer_1)
    invoice2 = create(:invoice, merchant: merchant1, customer: customer_1)
    get "/api/v1/customers/#{customer_1.id}/invoices"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(2)
  end

  # it "shows one customer's transactions" do
  #   create_list(:customer, 2)
  #   customer_1 = Customer.last
  #   merchant1 = Merchant.create(name: "This")
  #   invoice1 = create(:invoice, merchant: merchant1, customer: customer_1)
  #   invoice2 = create(:invoice, merchant: merchant1, customer: customer_1)
  #   transaction1 = Transaction.create(invoice: invoice1, credit_card_number: "12345")
  #   transaction1 = Transaction.create(invoice: invoice2, credit_card_number: "12345")
  #   get "/api/v1/customers/#{customer_1.id}/transactions"
  #
  #   expect(response).to be_successful
  #   transactions = JSON.parse(response.body)["data"]
  #   expect(transactions.count).to eq(2)
  # end
end
