class CreateAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :assignments do |t|
      t.references :training, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :due_date

      t.timestamps
    end
  end
end
