class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.date   :time
      t.string :food
      t.string :amount
      t.string :meal_time
      t.string :location
      t.string :sensory
      t.string :emotional

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end