module Spree
  Product.class_eval do
    scope :google_merchant_scope, includes(:taxons, {:master => :images})

    def google_merchant_description
      self.description
    end

    def google_merchant_title
      self.name
    end

    # <g:google_product_category> Apparel & Accessories > Clothing > Dresses (From Google Taxon Map)
    def google_merchant_product_category
      self.property(:gm_product_category) || Spree::GoogleMerchant::Config[:product_category]
    end

    def google_merchant_product_type
      return unless taxons.any?
      taxons[0].self_and_ancestors.map(&:name).join(" > ")
    end

    # <g:condition> new | used | refurbished
    def google_merchant_condition
      'new'
    end

    # <g:availability> in stock | available for order | out of stock | preorder
    def google_merchant_availability
      self.master.stock_items.first.count_on_hand > 0 ? 'in stock' : 'out of stock'
    end

    def google_merchant_quantity
      self.master.stock_items.first.count_on_hand
    end

    def google_merchant_image_link
      image = images.first and
          image_path = image.attachment.url(:product) and
          [Spree::GoogleMerchant::Config[:public_domain], image_path].join
    end

    def google_merchant_brand
      self.property(:brand)
    end

    # <g:price> 15.00 USD
    def google_merchant_price
      format("%.2f %s", self.price, self.currency).to_s
    end

    # <g:sale_price> 15.00 USD
    def google_merchant_sale_price
      unless self.property(:gm_sale_price).nil?
        format("%.2f %s", self.property(:gm_sale_price), self.currency).to_s
      end
    end

    # <g:sale_price_effective_date> 2011-03-01T13:00-0800/2011-03-11T15:30-0800
    def google_merchant_sale_price_effective_date
      unless self.property(:gm_sale_price_effective).nil?
        return # TODO
      end
    end

    def google_merchant_id
      self.id
    end

    # <g:gtin> 8-, 12-, or 13-digit number (UPC, EAN, JAN, or ISBN)
    def google_merchant_gtin
      self.master.gtin rescue self.upc
    end

    # <g:mpn> Alphanumeric characters
    def google_merchant_mpn
      self.sku.gsub(/[^0-9a-z ]/i, '')
    end

    # <g:gender> Male, Female, Unisex
    def google_merchant_gender
      value = self.property(:gender)
      return unless value.present?
      value.gsub('Girls','Female').gsub('Womens','Female').gsub('Boys','Male').gsub('Mens','Male')
    end

    # <g:age_group> Adult, Kids
    def google_merchant_age_group
      value = self.property(:agegroup)
      return unless value.present?
      value.gsub('Adults','Adult')
    end

    # <g:color>
    def google_merchant_color
      self.property(:color)
    end

    # <g:size>
    def google_merchant_size
      self.property(:size)
    end

    # <g:adwords_grouping> single text value
    def google_merchant_adwords_group
      self.property(:gm_adwords_group)
    end

    # <g:shipping_weight> # lb, oz, g, kg.
    def google_merchant_shipping_weight
      return unless self.weight.present?
      weight_units = 'oz'       # need a configuration parameter here
      format("%s %s", self.weight, weight_units)
    end

    # <g:adult> TRUE | FALSE
    def google_merchant_adult
      self.property(:gm_adult) unless self.property(:gm_adult).nil?
    end

  end
end