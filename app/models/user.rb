class User < ApplicationRecord

  has_secure_password
  has_many :professional_links, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_on_posts, through: :comments, source: :post
  has_many :followers, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  # All the people that follow the user
  has_many :following, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  # All the people the user is following

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  validate :password_conditions, on: :create
  validate :password_conditions, if: :password_exists?

  private

  def password_conditions
    minimum_length = 8
    errors.add :password, 'must include at least one uppercase letter' unless password =~ /\A(?=.*[A-Z])/
    errors.add :password, 'must include at least one lowercase letter' unless password =~ /\p{Lower}/
    errors.add :password, 'must include at least one number' unless password =~ /\A(?=.*[0-9])/
    errors.add :password, 'must include at least one special character' unless password =~ /\A(?=.*[^A-Za-z0-9])/
    errors.add :password, "is too short (minimum is #{minimum_length} characters)" unless password.length >= minimum_length
    errors.add :password, "can't be blank" unless password
  end

  def password_exists?
    password
  end
   
end
