class AddInstructorIdToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :instructor_id, :integer
  end
end
