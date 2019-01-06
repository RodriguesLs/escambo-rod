class Member < ActiveRecord::Base
  
  ratyrate_rater
  
  has_one :profile_member
  
  accepts_nested_attributes_for :profile_member
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
