class DropAssignmentQueue < ActiveRecord::Migration
  def change
    drop_table :assignment_queue
  end
end
