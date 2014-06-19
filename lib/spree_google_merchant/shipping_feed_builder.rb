module SpreeGoogleMerchant
  class ShippingFeedBuilder < FeedBuilder

    def filename
      "google_merchant_shipments_v#{@store.try(:code)}.txt"
    end

    def generate_xml file

      # Write header line
      file.write("merchant order id\ttracking number\tcarrier code\tother carrier name\tship date\n")

      ar_scope.find_each(:batch_size => 300) do |shipment|
        next unless validate_record(shipment)
        file.write("#{shipment.order.number}\t#{shipment.tracking}\t#{shipment.carrier_code}\t\t#{shipment.shipped_at.utc.strftime('%FT%T')}\n")
      end
    end

    def ar_scope
      if @store
        Spree::Shipment.by_store(@store).google_merchant_scope.scoped
      else
        Spree::Shipment.google_merchant_scope.scoped
      end
    end

    def validate_record(shipment)
      return false if shipment.order.nil? || shipment.order.number.nil?
      return false if shipment.shipped_at.nil?
      true
    end
  end
end