module Spree
  Order.class_eval do
    scope :google_merchant_scope, lambda { where("updated_at BETWEEN '#{1.day.ago.beginning_of_day}' AND '#{1.day.ago.end_of_day}' AND state = 'canceled' AND NOT ISNULL(cancel_reason)") }
  end
end