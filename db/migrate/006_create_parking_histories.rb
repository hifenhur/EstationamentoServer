# -*- encoding : utf-8 -*-
class CreateParkingHistories < ActiveRecord::Migration
  def self.up
    create_table :parking_histories do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :parking_histories
  end
end
