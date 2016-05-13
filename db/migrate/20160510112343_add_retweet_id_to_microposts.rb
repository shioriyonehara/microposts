class AddRetweetIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :retweet_id, :integer
  end
end
