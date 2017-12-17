class AddIndexToPostsIpAddress < ActiveRecord::Migration
  def change
    add_index :posts, :ip_address
  end
end
