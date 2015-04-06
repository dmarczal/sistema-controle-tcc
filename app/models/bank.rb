class Bank < ActiveRecord::Base
    has_and_belongs_to_many :teachers
    belongs_to :timeline

    def serialize
        ob = self.attributes.to_hash
        ob['teacher_ids'] = self.teacher_ids
        timeline = self.timeline
        student = timeline.student
        ob['student'] = student.name
        ob
    end
end
