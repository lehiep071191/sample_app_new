class Micropost < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_one_attached :image
	validates :user_id, presence: true
	validates :content, presence: true
	 scope :order_by_time,->{ order(created_at: :desc) }  
	def display_image
		image.variant(resize_to_limit: [500, 500])
	end	
end
