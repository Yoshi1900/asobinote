class AddGeocodingColumnToPlayground < ActiveRecord::Migration[6.1]
  def change
    change_column :playgrounds, :address, :string, null: false, default: ""
    add_column :playgrounds, :latitude, :float, null: false, default: 0
    add_column :playgrounds, :longitude, :float, null: false, default: 0
  end
end
