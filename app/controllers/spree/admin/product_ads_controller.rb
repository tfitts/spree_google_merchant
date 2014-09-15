module Spree
  module Admin
    class ProductAdsController < ResourceController
      before_filter :load_product
      before_filter :load_channel

      def index
        if @product
          @collection = Spree::ProductAd.where(:product => @product.id)
        end
      end

      private

      def load_product
        unless params[:product_id].nil?
          @product = Spree::Product.find(params[:product_id])
        end
      end

      def load_channel
        unless params[:product_ads_channel_id].nil?
          @channel = Spree::ProductAdChannel.find(params[:product_ad_channel_id])
        end
      end
    end
  end
end