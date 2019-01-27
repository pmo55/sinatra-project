class CreateReviews < ActiveRecord::Migration

  def change
    create_table :reviews do |t|
      t.string :product_name
      t.text :content
      t.integer :rating
      t.integer :user_id

    end


  end




end
