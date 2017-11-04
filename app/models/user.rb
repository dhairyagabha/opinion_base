class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable

  has_many :articles
  has_many :comments
  has_many :interactions
  has_many :followings, foreign_key: 'user_id'
  has_many :followers, class_name:'Following', as: 'follow'

  def follows(user)
    self.followings.where(follow_id: user, follow_type: 'User')
  end

end
