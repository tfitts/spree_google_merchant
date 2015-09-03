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
      "Occasion",
      "Sku Bid"
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
      index = 0
      start_time = Time.now
      ar_scope.find_each(:batch_size => 300) do |product|
        next unless validate_record(product)
        line = ""
        @@feed_attributes.each_with_index do |attr_name, index|
          method = "amazon_#{attr_name.downcase.tr(' ', '_')}"
          value = product.send(method)
          if index == 0
            line << "#{value}"
          else
            line << "\t#{value}"
          end
        end
        file.write("#{line}\n")
        
        # Log progress to console
        if(index % 20 == 0)
          percent = (((index.to_f + 1) / (@product_count.to_f + 1)) * 100).to_i
          current_time = Time.now
          elapsed_seconds = current_time - start_time
          rate = index/elapsed_seconds
          print "#{percent}% (#{index}/#{@product_count}) (#{rate}/sec)   \r"
        end
        
        index += 1
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
        products = Spree::Product.by_store(@store).amazon_ads.scoped
      else
        products = Spree::Product.amazon_ads.scoped
      end
      @product_count = products.length
      products
    end

    def validate_record(product)
      return false if product.images.length == 0 && product.image_size == 0 rescue true
      return false if product.master.stock_items.sum(:count_on_hand) <= 0
      return false if product.amazon_title.nil?
      return false if product.amazon_category.nil?
      return false if product.amazon_price.nil? || product.amazon_price.to_f <= 0
      return false if product.amazon_link.nil?
      return false if product.amazon_sku.nil?
      return false if product.respond_to?(:discontinued?) && product.discontinued? && self.master.stock_items.sum(:count_on_hand) <= 0
      return false unless validate_upc(product.upc)
      true
    end
  end
end