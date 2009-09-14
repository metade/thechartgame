class CreateCharts < ActiveRecord::Migration
  def self.up
    create_table :charts do |t|
      t.albums :string
      t.singles :string
      
      t.integer :year
      t.integer :week

      t.timestamps
    end
  end

  def self.down
    drop_table :charts
  end
end
