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

    execute <<-SQL
      CREATE TRIGGER sync_progression AFTER UPDATE ON clean_them_all_job_progressions FOR EACH ROW
      BEGIN
        IF NEW.aasm_state = 'completed' OR NEW.aasm_state = 'failed' OR NEW.aasm_state = 'aborted' THEN
          UPDATE
            clean_them_all_jobs
          SET
            aasm_state = 'confirming'
          WHERE
            id = NEW.id
           AND
            aasm_state = 'processing'
          ;
        END IF;
      END;
    SQL
  end
end
