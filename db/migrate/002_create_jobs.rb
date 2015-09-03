class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :user, null: false
      t.string     :aasm_state, limit: 30, null: false # NOTE: max key length is 767 bytes

      t.timestamps null: false
    end
    add_index :jobs, :user_id
    add_index :jobs, :aasm_state
  end
end
