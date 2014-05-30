class AdjustExistingTables < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :cohorts, :instructor, :string
    add_column :assignments, :due_date, :date
  end
end
