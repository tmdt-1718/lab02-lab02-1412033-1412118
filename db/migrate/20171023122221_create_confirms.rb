class CreateConfirms < ActiveRecord::Migration[5.1]
  def change
    create_table :confirms do |t|
      t.integer :user_1_id
      t.integer :user_2_id

      t.timestamps
    end
  end
end
