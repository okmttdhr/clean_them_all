class CreateJobParameters < ActiveRecord::Migration[5.1]
  def change
    create_table :job_parameters, primary_key: [:id] do |t|
      t.bigint     :id

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
      t.text       :start_message
      t.text       :finish_message
    end
  end
end
