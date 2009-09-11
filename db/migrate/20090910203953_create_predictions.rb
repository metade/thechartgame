class CreatePredictions < ActiveRecord::Migration
  def self.up
    create_table :predictions do |t|
      t.integer :user_id
      
      t.string :guess
      t.string :artists
      
      t.integer :year
      t.integer :week
      t.float :score

      t.timestamps
    end
  end

  def self.down
    drop_table :predictions
  end
end
