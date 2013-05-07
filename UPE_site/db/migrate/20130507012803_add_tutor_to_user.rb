class AddTutorToUser < ActiveRecord::Migration
  def change
    add_column :users, :tutor, :boolean, :default =>false
  end
end
