class Articles < ActiveRecord::Migration[5.2]
  def change
  
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.references :user
      t.timestamps
    end
  end
end
