class RemoveNamefromcohort < ActiveRecord::Migration
  def change
    remove_column :cohorts, :name, :string
  end
end
