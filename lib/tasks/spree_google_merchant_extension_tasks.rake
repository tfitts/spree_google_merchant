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

end
