# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  password     :string           not null
#  id_type_user :integer          not null
#

class User < ActiveRecord::Base
	before_save :set_base_64_password

	def set_base_64_password
		if self.password_changed?
			self.password = Base64.encode64(self.password)	
		end
	end
end
