class Student < ActiveRecord::Base
  has_many :timeline
  validates :ra, :presence => {message: 'O RA do aluno é um valor obrigatório' },
            :uniqueness => {message: 'O RA já foi cadastrado'}
  validates :name, :presence => { message: 'O nome do aluno é um valor obrigatório' }
  validates :email, :presence => { message: 'O e-mail do aluno é um valor obrigatório' }

  def login
    Login.find_by :entity_id => self.id, :access => 4
  end
end
