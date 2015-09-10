class CreateJobParameters < ActiveRecord::Migration
  def change
    create_table :job_parameters do |t|
      # extras
      t.datetime   :signedin_at,      null: false
      t.integer    :statuses_count,   null: false
      t.datetime   :registered_at,    null: false

      # options
      t.string     :collect_method,   null: false
      t.text       :archive_url
      t.boolean    :protect_reply,    default: false
      t.boolean    :protect_favorite, default: false
      t.date       :collect_from
      t.date       :collect_to
      t.string     :start_message
      t.string     :finish_message

      t.timestamps null: false
    end
  end
end
