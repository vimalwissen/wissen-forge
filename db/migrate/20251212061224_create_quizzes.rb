class CreateQuizzes < ActiveRecord::Migration[8.1]
  def change
    create_table :quizzes do |t|
      t.references :training, null: false, foreign_key: true
      t.jsonb :questions

      t.timestamps
    end
  end
end
