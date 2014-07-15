class Spree::Api::AdvertiserProductTypesController < ApplicationController
  respond_to :json

  def index

    # Find product types like given parameter
    @product_types = []
    if !params[:part].nil? && params[:part] != ""
      @product_types = Spree::AdvertiserProductType.where("product_type LIKE '%#{params[:part]}%'").scoped
    else
      @product_types = Spree::AdvertiserProductType.scoped
    end
    respond_with(@product_types.map{|t|t.product_type})
  end

end