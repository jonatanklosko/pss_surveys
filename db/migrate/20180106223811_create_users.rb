class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :wca_user_id, null: false
      t.string :wca_id
      t.string :name, null: false
      t.string :avatar_thumb_url

      t.timestamps
    end
  end
end
