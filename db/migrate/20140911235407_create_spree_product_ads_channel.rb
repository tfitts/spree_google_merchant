class CreateSpreeProductAdsChannel < ActiveRecord::Migration
  def change
    create_table :spree_product_ads_channel do |t|
      t.string :name
      t.string :presentation
      t.boolean :enabled, default: false
      t.decimal :min_cpc, default: nil, precision: 8, scale: 2
      t.timestamps
    end
  end
end
