class Api::V1::ItemsController < ApplicationController

  def index
    if params["merchant_id"]
      merchant = Merchant.find(params["merchant_id"])
      render json: ItemSerializer.new(merchant.items.all)
    elsif index_params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: ItemSerializer.new(invoice.items)
    elsif index_params
      render json: ItemSerializer.new(Item.find_all_by(index_params))
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    if item_params[:invoice_item_id]
      invoice_item = InvoiceItem.find(item_params[:invoice_item_id])
      render json: ItemSerializer.new(invoice_item.item)
    else
      render json: ItemSerializer.new(Item.find_record(item_params))
    end
  end

  def item_params
    params.permit(:id, :name, :description, :merchant_id, :created_at, :updated_at, :unit_price, :invoice_item_id)
  end

  def index_params
    params.permit(:created_at, :updated_at, :name, :description, :id, :unit_price, :invoice_id)
  end
end
