class Tweet < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belongs_to :user
	validates :subject, length: { maximum: 140 }
end
