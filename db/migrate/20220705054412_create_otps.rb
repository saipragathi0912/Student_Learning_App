class CreateOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :otps do |t|
      t.integer :otp
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
