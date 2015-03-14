class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :token,  null: false
      t.string  :secret, null: false
      t.string  :name

      t.timestamps null:false
    end
  end
end
