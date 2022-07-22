class DropOtpsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :otps
  end
end
