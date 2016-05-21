class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  belongs_to :retweet_origin, class_name: 'Micropost', foreign_key: 'retweet_id'
  has_many   :retweets, class_name: 'Micropost', foreign_key: 'retweet_id'
  
  def origin_name
    origin_user.name
  end
  
  def origin_user
    retweet_origin.user
  end
end
