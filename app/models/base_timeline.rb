class BaseTimeline < ActiveRecord::Base
  has_many :item_base_timeline

  validates :year, :presence => {message: 'O ano é um valor obrigatório.'},
            :length => {maximum: 4, message: 'Digite um ano válido.'}
  validates :half, :presence => {message: 'O semestre é um valor obrigatório.'},
            :length => {maximum: 1, message: 'Digite um semestre válido (1 ou 2).'}
  validates :tcc, :presence => {message: 'O TCC é um valor obrigatório.'},
            :length => {maximum: 1, message: 'Digite um valor válido para o TCC (1 ou 2)'}
  validate :calendar_is_unique, on: :create

  def calendar_is_unique
    timelines = BaseTimeline.where :year => self.year, :half => self.half, :tcc => self.tcc
    if timelines.length > 0
        errors.add(:tcc, 'Calendário já especificado.')
    end
  end
end
