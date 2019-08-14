class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :friend_invite, index: true
      t.references :invited_friend, index: true,unique: true
      t.boolean :accepted, :default => 'false'
      
      t.timestamps
    end
  end
end
