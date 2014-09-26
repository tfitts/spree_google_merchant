class CreateSpreeProductAds < ActiveRecord::Migration
  def change
    create_table :spree_product_ads do |t|
      t.integer :variant_id
      t.integer :product_ad_channel_id
      t.string  :state, default: 'disabled'
      t.decimal :max_cpc, default: 0, precision: 8, scale: 2
      t.timestamps
    end
  end
end
