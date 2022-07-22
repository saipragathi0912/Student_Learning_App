class AddChapterToContents < ActiveRecord::Migration[7.0]
  def change
    add_reference :contents, :chapter, null: false, foreign_key: true
  end
end
