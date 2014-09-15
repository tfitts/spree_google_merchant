module Spree
  module Admin
    class ProductAdChannelsController < ResourceController
      def index
        respond_with(@collection)
      end
    end
  end
end