# -*- encoding : utf-8 -*-
class CreateEnrollCards < ActiveRecord::Migration
  def self.up
    create_table :enroll_cards do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :enroll_cards
  end
end
