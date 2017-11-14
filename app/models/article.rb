class Article < ApplicationRecord

  include PgSearch
  pg_search_scope :search, :against => [:name, :excerpt, :body]

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, as: 'entity', dependent: :destroy
  has_many :interactions, as: 'entity', dependent: :destroy
  validates_presence_of :name, :body

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  def tag_list
    tags.map { |t| t.name }
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def likes
    self.interactions.where(interaction: 'Like').count
  end

  def read_later
    self.interactions.where(interaction: 'Save').count
  end

end