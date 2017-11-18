class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :articles
  has_many :comments
  has_many :interactions
  has_many :followings, foreign_key: 'user_id' #fetching people a user follows
  has_many :followers, class_name:'Following', as: 'follow' #fetching people who follow the user

  def follows(user)
    self.followings.where(follow_id: user, follow_type: 'User')
  end

end
