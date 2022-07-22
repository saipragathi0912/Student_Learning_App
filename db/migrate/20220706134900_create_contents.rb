class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :name
      t.string :content
      t.boolean :watched
      t.string :description
      t.boolean :upvote
      t.boolean :downvote
      t.string :notes
      t.references :subject, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
