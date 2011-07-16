class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :food
      t.string :amount
      t.time   :time
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