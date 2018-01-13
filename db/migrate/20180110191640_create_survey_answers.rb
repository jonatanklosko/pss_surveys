class CreateSurveyAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :survey_answers do |t|
      t.references :survey, index: true
      t.references :survey_question
      t.integer :rating, null: false
      t.text :comment

      t.timestamps
    end
  end
end
