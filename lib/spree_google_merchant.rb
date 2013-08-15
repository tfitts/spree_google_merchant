require 'spree_core'

module Spree
  module GoogleMerchant
    def self.config(&block)
      yield(Spree::GoogleMerchant::Config)
    end
  end
end

require 'spree_google_merchant/engine'


