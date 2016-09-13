class CreateNewTable < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :name, null: false 
			t.string :email, null: false, index: true
			t.string :password_digest, null: false
			t.boolean :login_status, default: false
			t.timestamps
		end

		create_table :tweets do |t|
			t.belongs_to :user, index: true, unique: true, foreign_key: true
			t.text :subject, null: false
			t.timestamps
		end

		create_table :followers do |t|
			t.integer :user_id_following, index:true
			t.integer :user_id_followed, index:true
			t.timestamps
		end
	end
end
