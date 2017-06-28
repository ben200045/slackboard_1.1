class CreateAssessments < ActiveRecord::Migration[5.0]
  def change
    create_table :assessments do |t|
      t.string :filler
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
