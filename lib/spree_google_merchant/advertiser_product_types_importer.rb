class SpreeGoogleMerchant::AdvertiserProductTypesImporter

  def self.import_plain_text_list(advertiser, file)

    # Read file contents
    contents = file.read

    # Create new advertiser product type if it doesn't already exist
    contents.each_line do |type|
      next if type.start_with?("#")
      unless !Spree::AdvertiserProductType.find_by_product_type(type).nil?
        Spree::AdvertiserProductType.create(:advertiser => advertiser, :product_type => type.strip)
      end
    end

  end

end