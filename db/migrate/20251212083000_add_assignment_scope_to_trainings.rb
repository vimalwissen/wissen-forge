class AddAssignmentScopeToTrainings < ActiveRecord::Migration[8.1]
  def change
    add_column :trainings, :assignment_scope, :integer, default: 0
    add_column :trainings, :target_departments, :string, array: true, default: []
    add_column :trainings, :target_user_ids, :integer, array: true, default: []
  end
end
