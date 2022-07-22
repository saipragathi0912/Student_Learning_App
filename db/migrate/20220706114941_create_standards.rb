class CreateStandards < ActiveRecord::Migration[7.0]
  def change
    create_table :standards do |t|
      t.integer :classid
      t.string :color

      t.timestamps
    end
  end
end
