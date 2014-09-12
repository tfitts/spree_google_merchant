class CreateProductAds < ActiveRecord::Migration
  def change
    create_table :spree_products_ads do |t|
      t.integer :variant_id
      t.integer :product_ads_channel_id
      t.boolean :enabled
      t.decimal :max_cpc, default: 0, precision: 8, scale: 2
      t.timestamps
    end
  end
end
