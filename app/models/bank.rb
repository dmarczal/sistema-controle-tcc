class Bank < ActiveRecord::Base
<<<<<<< HEAD
    has_many :teachers
    belongs_to :timeline
    validates :timeline, :presence => {message: 'Timeline é um valor obrigatório' },
            :uniqueness => {message: 'Esta banca já foi cadastrada'}
    validates :date, :presence => {message: 'Data da banca é um valor obrigatório' }

    def serialize

=======
    has_and_belongs_to_many :teachers
    belongs_to :timeline

    def serialize
        ob = self.attributes.to_hash
        ob['teacher_ids'] = self.teacher_ids
        timeline = self.timeline
        student = timeline.student
        ob['student'] = student.name
        ob
>>>>>>> ece3b5b
    end
end
