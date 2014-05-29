class AddCommentsEnrollmentAndAssignmentQueue < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :cohort_id

      t.timestamps
    end

    create_table :comments do |t|
      t.text :content
      t.references :commentable, polymorphic: true

      t.timestamps
    end

    create_table :assignment_queue do |t|
      t.integer :user_id
      t.integer :assignment_id

      t.timestamps
    end
  end
end
