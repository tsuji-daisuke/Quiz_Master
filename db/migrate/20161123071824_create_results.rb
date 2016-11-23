class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :question_id, null: false
      t.string :content, null: false
      t.string :judgement, null: false

      t.timestamps null: false
    end
  end
end
