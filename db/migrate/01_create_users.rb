class CreateUsers < ActiveRecord::Migration[4.2]

def change
create_table :users do |t|
  t.string :email
  t.text :username
  t.string :password_digest
    end

  end

end
