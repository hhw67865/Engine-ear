class UserInfoSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :pronouns, :email, :password_digest, :job_title, :employer, :open_to_work?, :profile_picture, :location, :follower_count, :following_count, :following_id
  has_many :professional_links
  has_many :posts
  has_many :comments
  has_many :followers, serializer: FollowersSerializer
  
  has_many :following, serializer: FollowingSerializer

  def follower_count
    self.object.followers.length
  end

  def following_count
    self.object.following.length
  end
  
  def following_id
    self.object.following.map { |follow| follow.followed_id}
  end
  
end
