module Spree
  class ProductAdChannel < ActiveRecord::Base
    has_many :product_ads
  end
end
