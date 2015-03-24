class Bank < ActiveRecord::Base
    has_many :teachers
    belongs_to :timeline
    validates :timeline, :presence => {message: 'Timeline é um valor obrigatório' },
            :uniqueness => {message: 'Esta banca já foi cadastrada'}
    validates :date, :presence => {message: 'Data da banca é um valor obrigatório' }

    def serialize

    end
end
