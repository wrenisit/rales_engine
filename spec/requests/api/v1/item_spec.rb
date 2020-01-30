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
end
