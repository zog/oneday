class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :user_id
      t.string :country

      t.timestamps
    end

    add_column :users, :bio, :text
  end
end
