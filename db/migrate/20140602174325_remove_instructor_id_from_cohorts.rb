class RemoveInstructorIdFromCohorts < ActiveRecord::Migration
  def change
    remove_column :cohorts, :instructor_id, :string
  end
end
