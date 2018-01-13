class CreateSurveyQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :survey_questions do |t|
      t.string :question, null: false
      t.text :description
      t.boolean :delegate, null: false, default: false

      t.timestamps
    end
  end
end
