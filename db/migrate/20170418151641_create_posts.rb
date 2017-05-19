class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :myaddress
      t.string :address
    
      t.timestamps null: false
    end
  end
end
