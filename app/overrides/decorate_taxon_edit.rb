Deface::Override.new(:virtual_path => "spree/admin/taxons/_form",
                     :name => "insert_google_product_type_selector",
                     :insert_bottom => "[data-hook='admin_inside_taxon_form']",
                     :partial => "spree/admin/taxons/advertiser_product_types",
                     :disabled => false)