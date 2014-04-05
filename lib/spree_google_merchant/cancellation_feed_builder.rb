module SpreeGoogleMerchant
  class CancellationFeedBuilder < FeedBuilder

    @@reason_map = {
      "buyercanceled" => "BuyerCanceled",
      "duplicateinvalid" => "DuplicateInvalid",
      "merchantcanceled" => "MerchantCanceled",
      "fraudfake" => "FraudFake"
    }

    def filename
      "google_merchant_cancellations_v#{@store.try(:code)}.txt"
    end

    def generate_xml file

      # Write header line
      file.write("merchant order id\treason\n")

      ar_scope.find_each(:batch_size => 300) do |order|
        next unless validate_record(order)
        file.write("#{order.number}\t#{@@reason_map[order.cancel_reason]}\n")
      end
    end

    def ar_scope
      if @store
        Spree::Order.by_store(@store).google_merchant_scope.scoped
      else
        Spree::Order.google_merchant_scope.scoped
      end
    end

    def validate_record(order)
      return false if order.number.nil?
      return false if !@@reason_map.has_key?(order.cancel_reason)
      true
    end
  end
end