class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :ip_address
      t.string :title, null: false
      t.text :text
      t.string :login
      t.float :rating, limit: 2, default: nil

      t.timestamps null: false
    end

  end
end
