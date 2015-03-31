class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user
  has_attached_file :image, 
  
  :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  :url => "https://s3-eu-west-1.amazonaws.com/yelppicbucket/:style/:image" , 
  :default_url => "https://s3-eu-west-1.amazonaws.com/yelppicbucket/:style/missing.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
def average_rating
  return 'N/A' if reviews.none?
  reviews.average(:rating)
end



end
