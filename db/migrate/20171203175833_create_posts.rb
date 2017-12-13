class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :ip_address
      t.string :title, null: false
      t.text :text
      t.integer :user_id, null: false
      t.integer :rating

      t.timestamps null: false
    end

  end
end
