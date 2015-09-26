class CreateJobArchives < ActiveRecord::Migration
  def change
    create_table :job_archives, id: false do |t|
      t.integer    :id,      limit: 8
      t.integer    :user_id, limit: 8
      t.string     :aasm_state

      t.timestamps null: false
    end
    execute "ALTER TABLE #{JobArchive.table_name} ADD PRIMARY KEY (id)"
  end
end
