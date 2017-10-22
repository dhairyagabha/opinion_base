class Comment < ApplicationRecord
  belongs_to :entity, polymorphic: true
  belongs_to :user

  has_many :comments, as: 'entity'

end
