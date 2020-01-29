class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:id] == "revenue" && params[:date]
      render json: MerchantSerializer.new(Merchant.revenue_by_date(params[:date]))
    #elsif
      #put more fancy code
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end


end
