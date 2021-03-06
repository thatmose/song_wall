class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :author, presence: true
  # validates :url
  belongs_to :user
  has_many :votes
end