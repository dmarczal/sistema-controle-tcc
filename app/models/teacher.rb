class Teacher < ActiveRecord::Base
  has_many :timeline
  has_and_belongs_to_many :banks
  has_many :bank_note

  validates :name, :presence => {message: 'O nome do professor é um valor obrigatório' }
  validates :access, :presence => {message: 'O tipo de acesso do professor é um valor obrigatório' }
  validates :email, :presence => {message: 'O email do professor é um valor obrigatório' }

  def login
    Login.where(['entity_id = ? AND access != 4', self.id]).first
  end
end