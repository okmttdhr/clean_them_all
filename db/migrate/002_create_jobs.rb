class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.references :user,              null: false
      t.string     :transition_state,  null: false, index: true
      t.string     :progression_state, null: false, index: true

      t.integer    :collect_count, default: 0
      t.integer    :destroy_count, default: 0
      t.boolean    :notified_start_message,  default: false
      t.boolean    :notified_finish_message, default: false
      t.datetime   :finished_at

      t.timestamps
    end
    add_index :jobs, [:user_id, :transition_state]
  end
end
