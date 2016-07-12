class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.integer :day_id
      t.integer :seq
      t.string :photo
      t.text :photo_meta
      t.time :time
      t.text :legend

      t.timestamps
    end
  end
end
