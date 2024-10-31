class CreateExpertises < ActiveRecord::Migration[7.2]
  def change
    create_table :expertises do |t|
      t.references :course, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.index [ :course_id, :topic_id ], unique: true

      t.timestamps
    end
  end
end
