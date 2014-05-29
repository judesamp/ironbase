class AddPolymorphicKeysToLinks < ActiveRecord::Migration
  def change
    add_column :links, :linkable_id, :integer
    add_column :links, :linkable_type, :string
  end
end