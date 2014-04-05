module Spree
  Shipment.class_eval do
    scope :google_merchant_scope, lambda { where("shipped_at BETWEEN '#{1.day.ago.beginning_of_day}' AND '#{1.day.ago.end_of_day}'") }
  end
end