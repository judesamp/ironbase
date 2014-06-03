class ChangeInstructorColumnInCohorts < ActiveRecord::Migration
  def change
    rename_column :cohorts, :instructor, :instructor_id
  end
end
