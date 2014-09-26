module Spree
  class ProductAdChannel < ActiveRecord::Base
    has_many :product_ads
    attr_accessible :name, :presentation, :min_cpc, :state, :default_max_cpc, :channel_type
  end
end
