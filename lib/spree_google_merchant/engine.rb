module SpreeGoogleMerchant
  class Engine < Rails::Engine
    engine_name 'spree_google_merchant'

    config.autoload_paths += %W( #{config.root}/lib )

    initializer "spree.google_merchant.environment", :before => :load_config_initializers do |app|
      Spree::GoogleMerchant::Config = Spree::GoogleMerchantConfiguration.new

      # See http://support.google.com/merchants/bin/answer.py?hl=en&answer=188494#US for all other fields
      SpreeGoogleMerchant::FeedBuilder::GOOGLE_MERCHANT_ATTR_MAP = [
          ['g:id', 'id'],
          ['g:gtin','gtin'],
          ['g:mpn', 'mpn'],
          ['title', 'title'],
          ['description', 'description'],
          ['g:price', 'price'],
          ['g:sale_price','sale_price'],
          ['g:sale_price_effective_date','sale_price_effective_date'],
          ['g:condition', 'condition'],
          ['g:product_type', 'product_type'],
          ['g:brand', 'brand'],
          ['g:quantity','quantity'],
          ['g:availability', 'availability'],
          ['g:image_link','image_link'],
          ['g:google_product_category','product_category'],
          ['g:shipping_weight','shipping_weight'],
          ['g:adult','adult'],
          ['g:gender','gender'],
          ['g:age_group','age_group'],
          ['g:color','color'],
          ['g:size','size'],
          ['g:adwords_grouping','adwords_group']
      ]
    end

    # SpreeGoogleMerchant::AmazonFeedBuilder::AMAZON_NODE_MAP = {
    #   "group:Costumes" => {
    #     "gender:Boys" => 727631011,
    #     "gender:Girls" => 727632011,
    #   }
    # }

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

  end
end