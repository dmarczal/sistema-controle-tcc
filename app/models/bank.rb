class Bank < ActiveRecord::Base
    has_and_belongs_to_many :teachers
    validates :teachers, :length => { :minimum => 1, message: 'Selecione pelo menos 1 professor para ser membro da banca.' }
    belongs_to :timeline
    belongs_to :bank_status
    validates_presence_of :date
    validates_presence_of :_type

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
