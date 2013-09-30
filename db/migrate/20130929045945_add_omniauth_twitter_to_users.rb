class AddOmniauthTwitterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_uid, :string
    add_column :users, :twitter_token, :string
    add_column :users, :twitter_name, :string
  end
end
