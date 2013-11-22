# -*- encoding : utf-8 -*-
class CreateCardTypes < ActiveRecord::Migration
  def self.up
    create_table :card_types do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :card_types
  end
end
