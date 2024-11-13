class CreatePostTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :post_taggings do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグは２回保存出来ない
    add_index :post_taggings, [:post_id,:tag_id],unique: true
  end
end
