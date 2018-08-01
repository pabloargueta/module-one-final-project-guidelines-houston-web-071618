class Scores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.belongs_to :user
      t.integer :score
    end
  end
end
