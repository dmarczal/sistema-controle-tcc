class BaseTimeline < ActiveRecord::Base
  has_many :item_base_timeline

  after_create :create_default_items

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

  def path
    '/'+year.to_s+'/'+half.to_s+'/'+tcc.to_s
  end

  def create_default_items
    params = tcc == "1" ? default_items_hash_tcc1 : default_items_hash_tcc2
    params.each do |param|
      param[:date] = Date.new year, 1, 1
      item = ItemBaseTimeline.create param
    end
  end

  def default_items_hash_tcc1
    [
      {
        title: 'Entrega da proposta de TCC para correção',
        _type: 'document',
        description: 'Entregar a proposta para professor de TCC 1, assim como, para o professor orientador para a correção.',
        base_timeline_id: id
      },
      {
        title: 'Entrega da proposta de TCC para avaliação',
        _type: 'document',
        description: 'Entregar a prposta de TCC digital e/ou encadernada ao professor de TCC 1, para que seja encaminhado para avaliação dos professores que participarão da banca de defesa de proposta. Acompanhado do projeto, o acadêmico deve entregar a Ficha de Autorização para Realização da Defesa de TCC assinada pelo seu orientador.',
        base_timeline_id: id
      }
    ]
  end

  def default_items_hash_tcc2
    [
      {
        title: 'Entrega da monografia de TCC para correção',
        _type: 'document',
        description: 'Entregar a monografia para professor de TCC 1, assim como, para o professor orientador para a correção.',
        base_timeline_id: id
      },
      {
        title: 'Entrega da monografia de TCC para avaliação',
        _type: 'document',
        description: 'Entregar a prposta de TCC digital e/ou encadernada ao professor de TCC 1, para que seja encaminhado para avaliação dos professores que participarão da banca de defesa de proposta. Acompanhado do projeto, o acadêmico deve entregar a Ficha de Autorização para Realização da Defesa de TCC assinada pelo seu orientador.',
        base_timeline_id: id
      }
    ]
  end
end
