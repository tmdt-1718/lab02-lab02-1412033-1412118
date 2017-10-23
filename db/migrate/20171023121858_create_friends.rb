class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.integer :user_1_id
      t.integer :user_2_id

      t.timestamps
    end
  end
end
