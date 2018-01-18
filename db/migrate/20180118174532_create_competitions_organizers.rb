class CreateCompetitionsOrganizers < ActiveRecord::Migration[5.1]
  def change
    create_table :competitions_organizers do |t|
      t.references :organizer, index: true
      t.references :competition, index: true
    end
  end
end
