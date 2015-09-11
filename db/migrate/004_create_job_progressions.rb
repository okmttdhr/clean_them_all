class CreateJobProgressions < ActiveRecord::Migration
  def change
    create_table :job_progressions, id: false do |t|
      t.integer :id, limit: 8
      t.string  :aasm_state, limit: 30, null: false # NOTE: max key length is 767 bytes
      t.integer :collect_count, default: 0
      t.integer :filter_count,  default: 0
      t.integer :destroy_count, default: 0

      t.timestamps null: false
    end
    execute "ALTER TABLE #{JobProgression.table_name} ADD PRIMARY KEY (id)"
    add_index :job_progressions, :aasm_state
  end
end
