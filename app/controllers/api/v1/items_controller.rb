class Api::V1::ItemsController < ApplicationController

  def index
    if params["merchant_id"]
      merchant = Merchant.find(params["merchant_id"])
      render json: ItemSerializer.new(merchant.items.all)
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

end
