class AddDescriptionsToAd < ActiveRecord::Migration
  def change
    add_column :ads, :description_md, :string
    add_column :ads, :description_short, :string
  end
end
