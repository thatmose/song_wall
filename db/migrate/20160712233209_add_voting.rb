class AddVoting < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :song
      t.boolean :upvote , default: false
      t.timestamps
    end
  end
end
