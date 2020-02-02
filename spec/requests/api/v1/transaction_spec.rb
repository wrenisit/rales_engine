require "rails_helper"

RSpec.describe "Transactions" do
  it "has transactions index" do
    create_list(:transaction, 3)
    get '/api/v1/transactions'

    expect(response).to be_successful
    transactions = JSON.parse(response.body)["data"]
    expect(transactions.count).to eq(3)
  end

  it "has transaction show" do
    create_list(:transaction, 3)
    transaction1 = Transaction.last
    get "/api/v1/transactions/#{transaction1.id}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)["data"]
    expect(transaction["id"]).to eq("#{transaction1.id}")
  end

  it "has transaction find by id" do
    create_list(:transaction, 3)
    transaction1 = Transaction.last
    get "/api/v1/transactions/find?id=#{transaction1.id}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)["data"]
    expect(transaction["id"]).to eq("#{transaction1.id}")
  end

  it "has transaction find by invoiceid" do
    create_list(:transaction, 3)
    transaction1 = Transaction.last
    get "/api/v1/transactions/find?invoice_id=#{transaction1.invoice_id}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)["data"]["attributes"]
    expect(transaction["invoice_id"]).to eq(transaction1.invoice_id)
  end

  it "has transaction find by cc number" do
    create_list(:transaction, 3)
    transaction1 = Transaction.last
    get "/api/v1/transactions/find?credit_card_number=#{transaction1.credit_card_number}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)["data"]["attributes"]
    expect(transaction["credit_card_number"]).to eq(transaction1.credit_card_number)
  end

  it "has transaction find by result" do
    create_list(:transaction, 3)
    transaction1 = Transaction.last
    get "/api/v1/transactions/find?result=#{transaction1.result}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)["data"]["attributes"]
    expect(transaction["result"]).to eq(transaction1.result)
  end

  it "has find all invoices associated with transaction" do
    merchant1 = Merchant.create(name: "That")
    create(:invoice, merchant: merchant1)
    invoice1 = Invoice.last
    transaction1 = Transaction.create(invoice: invoice1, credit_card_number: "12345")
    merchant3 = Merchant.create(name: "This")
    invoice2 = create(:invoice, merchant: merchant3)
    get "/api/v1/transactions/#{transaction1.id}/invoice"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)["data"]["attributes"]
    expect(invoices["id"]).to eq(invoice1.id)
  end
  # it "has transaction find by created_at" do
  #   create_list(:transaction, 3)
  #   transaction1 = Transaction.last
  #   get "/api/v1/transactions/find?created_at=#{transaction1.created_at}"
  #
  #   expect(response).to be_successful
  #   transaction = JSON.parse(response.body)["data"]["attributes"]
  #   expect(transaction["created_at"]).to eq(transaction1.created_at)
  # end
  #
  # it "has transaction find by updated_at" do
  #   create_list(:transaction, 3)
  #   transaction1 = Transaction.last
  #   get "/api/v1/transactions/find?updated_at=#{transaction1.updated_at}"
  #
  #   expect(response).to be_successful
  #   transaction = JSON.parse(response.body)["data"]["attributes"]
  #   expect(transaction["updated_at"]).to eq(transaction1.updated_at)
  # end
end
