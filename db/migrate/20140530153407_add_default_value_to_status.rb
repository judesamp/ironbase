class AddDefaultValueToStatus < ActiveRecord::Migration
  def change
    change_column :enrollments, :status, :string, default: "active"
  end
end
