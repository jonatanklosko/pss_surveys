class AddRemarkToCompetitions < ActiveRecord::Migration[5.1]
  def change
    add_column :competitions, :remark, :string
  end
end
