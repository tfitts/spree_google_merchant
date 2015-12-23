module Spree
  class ProductAd < ActiveRecord::Base
    belongs_to :variant
    belongs_to :product_ad_channel
    belongs_to :channel, :class_name => :ProductAdChannel, :foreign_key => "product_ad_channel_id"
    scope :active, -> {where("spree_product_ads.state <> 'disabled'")}
    scope :google_shopping, -> {joins(:channel).where("spree_product_ad_channels.channel_type = 'google_shopping'")}
    
    def self.in_feed
      includes({:variant => {:product => [:taxons, {:master => [:images, :stock_items, :default_price]}, :properties, :product_properties]}}, :channel)
      .references(:spree_products, :spree_prices, :spree_variants)
      .where("spree_variants.image_size > 0")
      .where("spree_products.name IS NOT NULL")
      .where("spree_prices.amount >= 0")
      .where("spree_prices.currency IS NOT NULL")
      .where("spree_variants.sku IS NOT NULL")
    end
  end
end