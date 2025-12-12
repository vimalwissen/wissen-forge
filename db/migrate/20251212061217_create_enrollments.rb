class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :training, null: false, foreign_key: true
      t.integer :status
      t.boolean :attendance
      t.integer :score
      t.datetime :completion_date

      t.timestamps
    end
  end
end
