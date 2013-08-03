class CreateQuips < ActiveRecord::Migration
  def change
    create_table :quips do |t|
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
