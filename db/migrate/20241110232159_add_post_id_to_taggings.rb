class AddPostIdToTaggings < ActiveRecord::Migration[6.0]
  def change
    add_column :taggings, :post_id, :integer
    add_index :taggings, :post_id
    add_foreign_key :taggings, :posts
  end
end
