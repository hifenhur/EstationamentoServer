# -*- encoding : utf-8 -*-
class CreateEnrollUsers < ActiveRecord::Migration
  def self.up
    create_table :enroll_users do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :enroll_users
  end
end
