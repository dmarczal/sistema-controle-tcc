class TeacherTimeline < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :timeline
end
