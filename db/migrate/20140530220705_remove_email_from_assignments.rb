class RemoveEmailFromAssignments < ActiveRecord::Migration
  def change
    remove_column :assignments, :email, :string
  end
end
