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
	validates_presence_of :name, :cpf
	validates :cpf, format: { with: /^\d{3}\.\d{3}\.\d{3}\-\d{2}$/, message: "o formato está incorreto" }
	before_save :clean_cpf
	

	def clean_cpf
		self.cpf = self.cpf.gsub(/[^\d]/, "")
	end

	def to_s
		name
	end

end
