class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, primary_key: [:id], options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.bigint :id

      t.string :token,  null: false
      t.string :secret, null: false
      t.string :name

      t.timestamps
    end
  end
end
