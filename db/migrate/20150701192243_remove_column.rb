class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :users, :websites
  	remove_column :users, :specialty
  end
end
