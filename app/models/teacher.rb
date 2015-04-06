class Teacher < ActiveRecord::Base
  has_many :timeline
  has_and_belongs_to_many :bank
  validates :name, :presence => {message: 'O nome do professor é um valor obrigatório' }
  validates :access, :presence => {message: 'O tipo de acesso do professor é um valor obrigatório' }
  validates :email, :presence => {message: 'O email do professor é um valor obrigatório' }
end