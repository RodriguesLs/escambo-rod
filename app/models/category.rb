class Category < ActiveRecord::Base
  
  has_many :ads
  
  validates :description, presence: true
  
  include FriendlyId
  friendly_id :description, use: :slugged

end
