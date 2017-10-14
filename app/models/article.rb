class Article < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :name, :body

end
