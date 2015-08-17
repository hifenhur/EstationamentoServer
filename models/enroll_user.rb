# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: enroll_users
#
#  id        :integer          not null, primary key
#  name      :text             not null
#  date_born :date
#  sex       :integer
#  cpf       :string(11)       not null
#

class EnrollUser < ActiveRecord::Base
	table_name = "users"
	has_many :cards, foreign_key: 'user_id', class_name: 'EnrollCard'
	validates_presence_of :name, :cpf
	validates :cpf, format: { with: /^\d{3}\.\d{3}\.\d{3}\-\d{2}$/, message: "o formato esta incorreto" }
	before_save :clean_cpf
	

	def clean_cpf
		self.cpf = self.cpf.gsub(/[^\d]/, "")
	end

	def to_s
		name
	end

	def sex_to_str
		if sex == 1
			"Masculino"
		else
			"Feminino"
		end
	end
end
