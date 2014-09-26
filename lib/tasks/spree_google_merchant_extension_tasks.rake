require 'net/ftp'

namespace :spree_google_merchant do

  task :update_cpc_values => [:environment] do |t, args|
    cpc_manager = Spree::CpcManager.new
    Spree::Variant.all.each{|v|cpc_manager.set_variant_cpc_and_update_ads(v)} if cpc_manager.is_setup?
  end

  task :generate_and_transfer => [:environment] do |t, args|
    SpreeGoogleMerchant::FeedBuilder.generate_and_transfer
  end

  task :generate => [:environment] do |t, args|
    SpreeGoogleMerchant::FeedBuilder.generate
  end

  task :transfer => [:environment] do |t, args|
    SpreeGoogleMerchant::FeedBuilder.transfer
  end

  task :generate_and_transfer_shipments => [:environment] do |t, args|
    SpreeGoogleMerchant::ShippingFeedBuilder.generate_and_transfer
  end

  task :generate_shipments => [:environment] do |t, args|
    SpreeGoogleMerchant::ShippingFeedBuilder.generate
  end

  task :transfer_shipments => [:environment] do |t, args|
    SpreeGoogleMerchant::ShippingFeedBuilder.transfer
  end

  task :generate_and_transfer_cancellations => [:environment] do |t, args|
    SpreeGoogleMerchant::CancellationFeedBuilder.generate_and_transfer
  end

  task :generate_cancellations => [:environment] do |t, args|
    SpreeGoogleMerchant::CancellationFeedBuilder.generate
  end

  task :transfer_cancellations => [:environment] do |t, args|
    SpreeGoogleMerchant::CancellationFeedBuilder.transfer
  end

  task :generate_and_transfer_amazon => [:environment] do |t, args|
    SpreeGoogleMerchant::AmazonFeedBuilder.generate_and_transfer
  end

  task :generate_amazon => [:environment] do |t, args|
    SpreeGoogleMerchant::AmazonFeedBuilder.generate
  end

  task :transfer_amazon => [:environment] do |t, args|
    SpreeGoogleMerchant::AmazonFeedBuilder.transfer
  end

  task :generate_and_transfer_ebay => [:environment] do |t, args|
    SpreeGoogleMerchant::EbayFeedBuilder.generate_and_transfer
  end

  task :generate_ebay => [:environment] do |t, args|
    SpreeGoogleMerchant::EbayFeedBuilder.generate
  end

  task :transfer_ebay => [:environment] do |t, args|
    SpreeGoogleMerchant::EbayFeedBuilder.transfer
  end

  task :generate_and_transfer_bing => [:environment] do |t, args|
    SpreeGoogleMerchant::BingFeedBuilder.generate_and_transfer
  end

  task :generate_bing => [:environment] do |t, args|
    SpreeGoogleMerchant::BingFeedBuilder.generate
  end

  task :transfer_bing => [:environment] do |t, args|
    SpreeGoogleMerchant::BingFeedBuilder.transfer
  end
end
