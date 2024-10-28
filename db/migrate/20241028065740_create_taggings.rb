class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.references :playground, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグは２回保存出来ない
    add_index :taggings, [:playground_id,:tag_id],unique: true
  end
end
