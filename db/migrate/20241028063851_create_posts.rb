class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :playground, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.float :star
      t.boolean :is_displayed, null: false, default: true
      t.timestamps
    end
  end
end
