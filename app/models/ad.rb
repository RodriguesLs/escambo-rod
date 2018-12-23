class Ad < ActiveRecord::Base
  belongs_to :member
  belongs_to :category
  
  # gem Money_rails
  monetize :price_cents
end
