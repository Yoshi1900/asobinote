class CreatePlaygrounds < ActiveRecord::Migration[6.1]
  def change
    create_table :playgrounds do |t|
      t.references :user, foreign_key: true
      t.string :name,null: false
      t.text :description
      t.string :post_code, null: false
      t.text :address, null: false
      t.string :phone_number, null: false, default: ""
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
