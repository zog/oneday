class RemoveBio < ActiveRecord::Migration
  def change
    add_column :days, :description, :text
    Day.all.each do |d|
      d.description = d.user.bio
      d.save
    end
    Day.reset_column_information
    remove_column :users, :bio
  end
end
