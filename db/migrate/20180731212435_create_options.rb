class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.belongs_to :question
      t.string :name
      t.boolean :is_correct
    end
  end
end
