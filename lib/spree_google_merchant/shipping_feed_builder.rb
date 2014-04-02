module SpreeGoogleMerchant
  class ShippingFeedBuilder
    extend FeedBuilder

    def filename
      "google_merchant_shipping_v#{@store.try(:code)}.xml"
    end

    def generate_xml output
      xml = Builder::XmlMarkup.new(:target => output)
      xml.instruct!

      xml.rss(:version => '2.0', :"xmlns:g" => "http://base.google.com/ns/1.0") do
        xml.channel do
          build_meta(xml)

          ar_scope.find_each(:batch_size => 300) do |shipment|
            next unless validate_record(shipment)
            build_shipment(xml, shipment)
          end
        end
      end
    end

    def ar_scope
      if @store
        Spree::Shipment.by_store(@store).google_merchant_shipping_scope.scoped
      else
        Spree::Shipment.google_merchant_shipping_scope.scoped
      end
    end

    def build_shipment(xml, shipment)
      xml.item do
        
      end
    end

    def validate_record(shipment)
      return true # TODO
    end
  end
end