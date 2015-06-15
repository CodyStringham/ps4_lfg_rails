class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :gamertag
      t.boolean :mic
      t.string :region
      t.string :language

      t.timestamps null: false
    end
  end
end
