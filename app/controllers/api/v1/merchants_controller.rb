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
    elsif params[:name]
      render json: MerchantSerializer.new(Merchant.find_by(name: params[:name]))
    elsif params[:created_at]
      render json: MerchantSerializer.new(Merchant.find_by(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: MerchantSerializer.new(Merchant.find_by(updated_at: params[:updated_at]))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end


end
