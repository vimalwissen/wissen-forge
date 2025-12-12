class CreateSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assignment, null: false, foreign_key: true
      t.string :file_url
      t.integer :grade

      t.timestamps
    end
  end
end
