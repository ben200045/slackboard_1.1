class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_description
      t.string :course_start_date
      t.string :course_end_date

      t.timestamps
    end
  end
end
