class AddSeenToReceivemails < ActiveRecord::Migration[5.1]
  def change
    add_column :receivemails, :seen, :boolean
  end
end
