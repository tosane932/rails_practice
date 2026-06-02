class CreateLearningLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :learning_logs do |t|
      t.date :learned_on
      t.integer :duration_mins
      t.text :memo

      t.timestamps
    end
  end
end
