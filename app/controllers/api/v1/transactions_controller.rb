class Api::V1::TransactionsController < ApplicationController

  def index
    if index_params
      render json: TransactionSerializer.new(Transaction.find_all_by(index_params))
    else
      render json: TransactionSerializer.new(Transaction.all)
    end
  end

  def show
    render json: TransactionSerializer.new(Transaction.find_record(transaction_params))
  end

  def transaction_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end

  def index_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at, :customer_id)
  end
end
