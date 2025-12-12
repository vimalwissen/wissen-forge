class CreateTrainings < ActiveRecord::Migration[8.1]
  def change
    create_table :trainings do |t|
      t.string :title
      t.text :description
      t.integer :training_type
      t.integer :mode
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity
      t.string :instructor
      t.string :department_target
      t.integer :status

      t.timestamps
    end
  end
end
