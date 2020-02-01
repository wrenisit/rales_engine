class Api::V1::InvoicesController < ApplicationController

  def index
    if index_params
      render json: InvoiceSerializer.new(Invoice.find_all_by(index_params))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_record(invoice_params))
  end

  def invoice_params
    params.permit(:id, :customer_id, :merchant_id, :created_at, :updated_at)
  end

  def index_params
    params.permit(:id, :customer_id, :merchant_id, :created_at, :updated_at)
  end
end
