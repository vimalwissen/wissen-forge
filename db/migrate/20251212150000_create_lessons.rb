class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.references :training, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.text :content
      t.string :video_url
      t.integer :position, default: 0
      t.integer :duration_minutes, default: 0

      t.timestamps
    end
  end
end
