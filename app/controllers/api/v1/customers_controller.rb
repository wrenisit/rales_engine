class Api::V1::CustomersController < ApplicationController

  def index
    if index_params
      render json: CustomerSerializer.new(Customer.find_all_by(index_params))
    else
      render json: CustomerSerializer.new(Customer.all)
    end
  end

  def show
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: CustomerSerializer.new(invoice.customer)
    else
      render json: CustomerSerializer.new(Customer.find_record(customer_params))
    end
  end

  def customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at, :invoice_id)
  end

  def index_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
