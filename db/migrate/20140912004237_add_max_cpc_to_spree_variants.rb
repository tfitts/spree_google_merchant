class AddMaxCpcToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :max_cpc, :decimal, :precision => 8, :scale => 2, :default => 0.15
  end
end
