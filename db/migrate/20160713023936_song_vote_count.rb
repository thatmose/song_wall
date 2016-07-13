class SongVoteCount < ActiveRecord::Migration
  def change
    add_column :songs, :num_upvotes, :integer, default: 0
  end
end
