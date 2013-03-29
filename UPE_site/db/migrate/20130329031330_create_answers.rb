class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :solution

      t.timestamps
    end
  end
end
