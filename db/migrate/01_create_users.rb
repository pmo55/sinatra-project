def CreateUsers < ActiveRecord::Migration

def change
create_table :users do |t|
  t.string :email
  t.text :username
  t.string :password_digest
    end

  end

end
