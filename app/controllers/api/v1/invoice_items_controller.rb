class Api::V1::InvoiceItemsController < ApplicationController

  def index
    if index_params
      render json: InvoiceItemSerializer.new(InvoiceItem.find_all_by(index_params))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.all)
    end
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_record(invoice_item_params))
  end

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

  def index_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
