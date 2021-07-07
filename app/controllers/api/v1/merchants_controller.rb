class Api::V1::MerchantsController < ApplicationController

  def index
    if params[:id]
      render json: MerchantSerializer.new(Merchant.find_records_by(:id, params[:id]))
    elsif params[:name]
      render json: MerchantSerializer.new(Merchant.find_records_by(:name, params[:name]))
    elsif params[:created_at]
      render json: MerchantSerializer.new(Merchant.find_records_by(:created_at, params[:created_at]))
    elsif params[:updated_at]
      render json: MerchantSerializer.new(Merchant.find_records_by(:updated_at, params[:updated_at]))
    else
      render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    if params[:id] == "revenue" && params[:date]
      render json: MerchantSerializer.new(Merchant.revenue_by_date(params[:date]))
    elsif params[:item_id]
      item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(item.merchant)
    elsif params[:name]
      render json: MerchantSerializer.new(Merchant.find_by(name: params[:name]))
    elsif params[:created_at]
      render json: MerchantSerializer.new(Merchant.find_by(created_at: params[:created_at]))
    elsif params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: MerchantSerializer.new(invoice.merchant)
    elsif params[:updated_at]
      render json: MerchantSerializer.new(Merchant.find_by(updated_at: params[:updated_at]))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end


end
