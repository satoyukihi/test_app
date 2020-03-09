class CreateTagRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_relationships do |t|
      t.integer :topic_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :tag_relationships, [:topic_id,:tag_id],unique: true
  end
end
