class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
