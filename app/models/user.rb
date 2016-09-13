class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	has_secure_password
	validates :email, uniqueness: true, presence: true
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
	validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40},
                       :on => :create
	has_many :tweets 
	# has_many :followers, foreign_key: "user_id_following"
	# has_many :followers, foreign_key: "user_id-followed"

	def show_detail?(followed_obj, following_obj)
		followed_obj.where(user_id_following: following_obj.id).count != 0
	end

end
