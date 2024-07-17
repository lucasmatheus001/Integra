class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :birthday
      t.integer "role", default: 1
      t.integer "status", default: 1

      t.timestamps
    end
  end
end
