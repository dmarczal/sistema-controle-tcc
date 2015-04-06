class Teacher < ActiveRecord::Base
  has_many :timeline
<<<<<<< HEAD
  belongs_to :bank
  belongs_to :teacher
=======
  has_and_belongs_to_many :bank
>>>>>>> ece3b5b
  validates :name, :presence => {message: 'O nome do professor é um valor obrigatório' }
  validates :access, :presence => {message: 'O tipo de acesso do professor é um valor obrigatório' }
  validates :email, :presence => {message: 'O email do professor é um valor obrigatório' }
end
