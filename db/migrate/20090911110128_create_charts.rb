class CreateCharts < ActiveRecord::Migration
  def self.up
    create_table :charts do |t|
      t.string :albums
      t.string :singles
      
      t.integer :year
      t.integer :week

      t.timestamps
    end
  end

  def self.down
    drop_table :charts
  end
end
