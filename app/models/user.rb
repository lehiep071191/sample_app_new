class User < ApplicationRecord
	has_many :microposts,dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :active_relationships, class_name: "Relationship",
									foreign_key: "follower_id",
									dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship",
									foreign_key: "followed_id",
									dependent: :destroy								
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower								
	before_save :downcase_email
	attr_accessor :remember_token, :reset_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
						format: { with: VALID_EMAIL_REGEX }, 
						uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true	
    class << self
	    def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end	

		def new_token
			SecureRandom.urlsafe_base64
		end
	end	
	def remember
		self.remember_token = User.new_token
		update remember_digest: User.digest(remember_token)
	end
    def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update remember_digest: nil
	end
	def current_user?(user)
		user && user == self
	end
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end
	def feed
		following_ids = "SELECT followed_id FROM relationships
			WHERE follower_id = :user_id"
		Micropost.where("user_id IN (#{following_ids})
			OR user_id = :user_id", user_id: id)
	end	
	def display_image
		image.variant(resize_to_limit: [500, 500])
	end	
	def follow(other_user)
		following << other_user
	end
	# Unfollows a user.
	def unfollow(other_user)
		following.delete(other_user)
	end
	# Returns true if the current user is following the other user.
	def following?(other_user)
		following.include?(other_user)
	end	
	private 
	def downcase_email
		self.email = email.downcase						
	end					
end
