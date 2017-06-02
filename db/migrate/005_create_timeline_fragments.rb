class CreateTimelineFragments < ActiveRecord::Migration[5.1]
  def change
    create_table :timeline_fragments, primary_key: [:id] do |t|
      t.bigint     :id
      t.references :job, null: false, index: true
    end
  end
end
