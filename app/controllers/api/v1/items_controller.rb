class Api::V1::ItemsController < ApplicationController

  def index
    if params["merchant_id"]
      merchant = Merchant.find(params["merchant_id"])
      render json: ItemSerializer.new(merchant.items.all)
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    if params[:id]
      render json: ItemSerializer.new(Item.find(params[:id]))
    elsif params[:name]
      render json: ItemSerializer.new(Item.find_by(name: params[:name]))
    elsif params[:description]
      render json: ItemSerializer.new(Item.find_by(description: params[:description]))
    elsif params[:created_at]
      render json: ItemSerializer.new(Item.find_by(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: ItemSerializer.new(Item.find_by(updated_at: params[:updated_at]))
    end
  end
end
