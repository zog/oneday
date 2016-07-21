class AddLtLngToDays < ActiveRecord::Migration
  def change
    add_column :days, :lat, :float
    add_column :days, :lng, :float
  end
end
