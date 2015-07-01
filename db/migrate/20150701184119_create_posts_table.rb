class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.string :user_id
  		t.timestamps :post_time
  		t.string :body
  	end
  end
end
