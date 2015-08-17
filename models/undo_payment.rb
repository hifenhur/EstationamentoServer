# == Schema Information
#
# Table name: undo_payments
#
#  id           :integer          not null, primary key
#  id_payment   :integer          not null
#  id_user_ins  :integer          not null
#  obs_ins      :string           not null
#  dt_ins       :datetime         not null
#  id_user_auth :integer
#  obs_auth     :string
#  dt_auth      :datetime
#

class UndoPayment < ActiveRecord::Base
	
end
