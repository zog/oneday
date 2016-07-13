class AddTitleToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :title, :string
  end
end
