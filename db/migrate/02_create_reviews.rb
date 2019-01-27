class CreateReviews < ActiveRecord::Migration[4.2]

  def change
    create_table :reviews do |t|
      t.string :product_name
      t.text :content
      t.integer :rating
      t.integer :user_id

    end

  end

end
