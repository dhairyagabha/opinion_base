class Following < ApplicationRecord
  belongs_to :user
  belongs_to :follow, polymorphic: true
end
