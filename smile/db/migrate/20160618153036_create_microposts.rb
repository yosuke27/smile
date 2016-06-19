class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.integer :datecode
      t.integer :user_id
      t.text :content
      t.integer :mood
      t.boolean :is_onechance

      t.timestamps null: false
    end
  end
end
