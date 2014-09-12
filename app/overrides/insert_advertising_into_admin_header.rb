Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "advertising_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:advertising, :icon => 'icon-file', :destination_url => admin_product_ads_channels_path) %>",
                     :disabled => false)
