class AddSkillsToTrainings < ActiveRecord::Migration[7.0]
  def change
    add_column :trainings, :skills, :string, array: true, default: []
  end
end
