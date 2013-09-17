class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :heading, null: false
      t.string :short_description, null: false
      t.text :body, null: false
      t.boolean :published, null: false, default: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
