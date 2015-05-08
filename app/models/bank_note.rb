class BankNote < ActiveRecord::Base
    belongs_to :teacher
    belongs_to :bank

    validates :teacher, :presence => {message: 'Especifique um professor.'}
    validates :bank, :presence => {message: 'Especifique uma banca.'}
    validates_uniqueness_of :teacher_id, scope: :bank_id, message: 'Esse professor já deu nota para esta banca.'
end
