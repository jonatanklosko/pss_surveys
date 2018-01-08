class CreateCompetitions < ActiveRecord::Migration[5.1]
  def change
    create_table :competitions do |t|
      t.string :wca_competition_id, null: false
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :competitors_count, null: false
      t.datetime :surveys_closed_at

      t.timestamps
    end
  end
end
