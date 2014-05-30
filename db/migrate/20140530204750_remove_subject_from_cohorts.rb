class RemoveSubjectFromCohorts < ActiveRecord::Migration
  def change
    remove_column :cohorts, :subject, :string
  end
end
