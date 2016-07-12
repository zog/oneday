class AddPermalinkToDays < ActiveRecord::Migration
  def change
    add_column :days, :permalink, :string
  end
end
