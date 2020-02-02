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
end
