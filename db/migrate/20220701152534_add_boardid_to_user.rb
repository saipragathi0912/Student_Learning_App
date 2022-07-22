class AddBoardidToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :board_id, :bigint
  end
end
