class Password < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :student

  validates :teacher_id, presence: true, :unless => :student_id?
  validates :student_id, presence: true, :unless => :teacher_id?
  validates :password, presence: true

  def check?(pass)
    password == pass
  end
end
