# -*- encoding : utf-8 -*-
class CreateParkingCostHistories < ActiveRecord::Migration
  def self.up
    create_table :parking_cost_histories do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :parking_cost_histories
  end
end
