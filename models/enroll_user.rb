# == Schema Information
#
# Table name: enroll_users
#
#  id        :integer          not null, primary key
#  name      :string           not null
#  date_born :date
#  sex       :integer
#  cpf       :string(11)       not null
#

# -*- encoding : utf-8 -*-
class EnrollUser < ActiveRecord::Base
	has_many :cards, foreign_key: 'user_id', class_name: 'EnrollCard'

	def to_s
		name
	end
end
