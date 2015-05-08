class Bank < ActiveRecord::Base
    has_and_belongs_to_many :teachers
    belongs_to :timeline
    has_many :bank_note

    def serialize
        ob = self.attributes.to_hash
        ob['teacher_ids'] = self.teacher_ids
        timeline = self.timeline
        student = timeline.student
        ob['student'] = student.name
        ob['timeline_tcc'] = timeline.base_timeline.tcc
        ob['timeline_half'] = timeline.base_timeline.half
        ob['timeline_year'] = timeline.base_timeline.year
        ob
    end

    def notify
        UsersMailer.notifyStudentItNewBank(self).deliver_now
        UsersMailer.notifyTeacherItNewBank(self).deliver_now
    end
end
