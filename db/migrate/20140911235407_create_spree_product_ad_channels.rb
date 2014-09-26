class CreateSpreeProductAdChannels < ActiveRecord::Migration
  def change
    create_table :spree_product_ad_channels do |t|
      t.string :name
      t.string :presentation
      t.string :state, default: 'disabled'
      t.string :channel_type
      t.decimal :default_max_cpc, default: nil, precision: 8, scale: 2, default: 0
      t.decimal :min_cpc, default: nil, precision: 8, scale: 2, default: 0
      t.timestamps
    end
  end
end
