class CreateCategoriesUsersTable < ActiveRecord::Migration
  def change
    create_table :categories_users do |t|
      t.references :category, null: false
      t.references :user, null: false
    end

    add_index :categories_users, [ :category_id, :user_id ], unique: true
  end
end
