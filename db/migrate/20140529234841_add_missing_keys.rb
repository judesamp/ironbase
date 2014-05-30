class AddMissingKeys < ActiveRecord::Migration
  def change
    add_column :assignments, :cohort_id, :integer
  end
end
