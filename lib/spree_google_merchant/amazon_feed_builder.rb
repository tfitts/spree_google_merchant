require 'net/sftp'

module SpreeGoogleMerchant
  class AmazonFeedBuilder < FeedBuilder

    @@feed_attributes = [
      "Category",
      "Title",
      "Link",
      "SKU",
      "Price",
      "Image",
      "UPC",
      "Brand",
      "Recommended Browse Node",
      "Department",
      "Description",
      "Manufacturer",
      "Mfr part number",
      "Shipping Cost",
      "Item package quantity",
      "Size",
      "Color",
      "Gender",
      "Material",
      "Occasion"
    ]

    def filename
      "amazon_product_ads.txt"
    end

    def generate_xml file

      # Write header line
      @@feed_attributes.each_with_index do |attr_name, index|
        if index == 0
          file.write("#{attr_name}")
        else
          file.write("\t#{attr_name}")
        end
      end
      file.write("\n");

      # Write row for each product
      ar_scope.find_each(:batch_size => 300) do |product|
        next unless validate_record(product)
        @@feed_attributes.each_with_index do |attr_name, index|
          method = "amazon_#{attr_name.downcase.tr(' ', '_')}"
          value = product.send(method)
          if index == 0
            file.write("#{value}")
          else
            file.write("\t#{value}")
          end
        end
        file.write("\n")
      end
    end

    def transfer_xml
      raise "Please configure your Google Merchant :ftp_username and :ftp_password by configuring Spree::GoogleMerchant::Config" unless
          Spree::GoogleMerchant::Config[:amazon_sftp_username] and Spree::GoogleMerchant::Config[:amazon_sftp_password]

      Net::SFTP.start('productads.amazon-digital-ftp.com', Spree::GoogleMerchant::Config[:amazon_sftp_username], :password => Spree::GoogleMerchant::Config[:amazon_sftp_password]) do |sftp|
        sftp.upload(path, filename)
      end
    end

    def ar_scope
      if @store
        Spree::Product.by_store(@store).amazon_ads.scoped
      else
        Spree::Product.amazon_ads.scoped
      end
    end

  end
end