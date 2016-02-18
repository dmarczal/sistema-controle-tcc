class Bank < ActiveRecord::Base
    validates :teachers, :length => { :minimum => 1, message: 'Selecione pelo menos 1 professor para ser membro da banca.' }

    has_and_belongs_to_many :teachers
    belongs_to :timeline
    has_one :approval
    belongs_to :bank_status # TODO: REMOVE, NOT USED!
    validates_presence_of :date
    validates_presence_of :_type

    def advisors
      timeline.teachers.map { |t| t.name }.join(', ')
    end

    def student
      @student ||= timeline.student
    end

    def tcc1?
      self._type == 'tcc1' || self._type == 'proposta'
    end

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
        UsersMailer.notifyStudentItNewBank(self).deliver!
        UsersMailer.notifyTeacherItNewBank(self).deliver!
    end

    def self.next_banks
        where('date >= ?', Date.today)
    end

    def self.prev_banks
        where('date < ?', Date.today)
    end

end
