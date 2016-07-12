class AddVoting < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user_id
      t.references :song_id
      t.boolean :upvote
      t.timestamps
    end
  end
end
