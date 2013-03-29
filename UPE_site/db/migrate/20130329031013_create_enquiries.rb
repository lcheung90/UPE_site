class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
