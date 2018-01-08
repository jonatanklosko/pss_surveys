class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.references :competition, index: true
      t.string :secret_id, index: true, unique: true
      t.string :competitor_email, null: false
      t.integer :competitor_competitions_count
      t.boolean :delegate, null: false, default: false
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
