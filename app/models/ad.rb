class Ad < ActiveRecord::Base
  belongs_to :member
  belongs_to :category
  
  #Validates
  validates_presence_of :title, :description, :price, :category, :finish_date
  
  scope :descending_order, -> (quantity = 6) {limit(quantity).order(created_at: :desc)}
  
  has_attached_file :picture, styles: { medium: "320x150#", thumb: "100x100>" }, 
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # gem Money_rails
  monetize :price_cents
end
