class CreateReceivemails < ActiveRecord::Migration[5.1]
  def change
    create_table :receivemails do |t|
      t.integer :user_id
      t.integer :message_id

      t.timestamps
    end
  end
end
