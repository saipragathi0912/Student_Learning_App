class RemoveSubjectFromContents < ActiveRecord::Migration[7.0]
  def change
    remove_reference :contents, :subject, null: false, foreign_key: true
  end
end
