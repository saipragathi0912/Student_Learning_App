class AddClassidToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :class_id, :bigint
  end
end
