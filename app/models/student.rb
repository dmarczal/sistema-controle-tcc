class Student < ActiveRecord::Base
  has_many :timeline
  validates :ra, :presence => {message: 'O RA do aluno é um valor obrigatório' },
            :uniqueness => {message: 'O RA já foi cadastrado'}
  validates :name, :presence => { message: 'O nome do aluno é um valor obrigatório' }
end
