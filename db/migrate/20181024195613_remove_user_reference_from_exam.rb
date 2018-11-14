class RemoveUserReferenceFromExam < ActiveRecord::Migration[5.2]
  def change
    # Exam belongs to Course
    remove_column :exams, :user_id
    add_reference :exams, :course
  end
end
