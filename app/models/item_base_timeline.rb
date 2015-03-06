class ItemBaseTimeline < ActiveRecord::Base
  belongs_to :base_timeline
  has_many :item_timeline

  validates :description, :presence => {message: 'A descrição do item é um valor obrigatório.'}
  validates :title, :presence => {message: 'O título do item é um valor obrigatório.'}
  validates :_type, :presence => {message: 'O tipo do item é um valor obrigatório.'}
  validates :link, :presence => {message: 'O link do item é um valor obrigatório.'}
  validates :date, :presence => {:message => 'A data do item é um valor obrigatório.'}
end
