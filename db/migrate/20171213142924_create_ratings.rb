class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :post_id
      t.float :rating_value, limit: 2, null: :no

      t.timestamps null: false
    end
    add_index :ratings, :post_id
    add_index :ratings, :rating_value
  end
end
