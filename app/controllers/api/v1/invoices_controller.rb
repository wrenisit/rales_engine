class Api::V1::InvoicesController < ApplicationController

  def index
    if index_params
      render json: InvoiceSerializer.new(Invoice.find_all_by(index_params))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    if params[:transaction_id]
      transaction = Transaction.find(params[:transaction_id])
      render json: InvoiceSerializer.new(transaction.invoice)
    else
      render json: InvoiceSerializer.new(Invoice.find_record(invoice_params))
    end
  end

  def invoice_params
    params.permit(:id, :customer_id, :merchant_id, :created_at, :updated_at, :transaction_id)
  end

  def index_params
    params.permit(:id, :customer_id, :merchant_id, :created_at, :updated_at)
  end
end
