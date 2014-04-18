require 'net/ftp'

namespace :spree_google_merchant do
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
end
