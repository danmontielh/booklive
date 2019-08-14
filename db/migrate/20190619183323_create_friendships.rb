class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :friend_invite
      t.references :invited_friend
      t.boolean :accepted, :default => 'false'
     
      
      t.timestamps
    end
      add_index :friendships, [:friend_invite_id, :invited_friend_id], unique: true
  end
end
