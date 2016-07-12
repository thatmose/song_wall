class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :author, presence: true
  validates :url
end