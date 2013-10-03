class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id
      t.string :author_name
      t.integer :post_id

      # awesome_nested_set
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
