class CreateJobProgressions < ActiveRecord::Migration
  def change
    create_table :job_progressions do |t|
       t.string  :aasm_state
      t.integer :collect_count, default: 0
      t.integer :filter_count,  default: 0
      t.integer :destroy_count, default: 0

      t.timestamps null: false
    end
  end
end
