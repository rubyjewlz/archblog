class CreateProfileTable < ActiveRecord::Migration
  def change
  	create_table :profile do |t|
	  	t.date :birthday
	  	t.string :website
	  	t.string :specialty
	  	t.string :location
	  	t.integer :user_id
	end
  end
end
