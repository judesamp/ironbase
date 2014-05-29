class AddForeignKeysToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :course_id, :integer
    add_column :cohorts, :location_id, :integer
  end
end
