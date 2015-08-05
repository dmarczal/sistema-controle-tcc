class BaseTimeline < ActiveRecord::Base
  has_many :item_base_timeline

  after_create :create_default_items
  before_destroy :delete_items

  validates :year, :presence => {message: 'O ano é um valor obrigatório.'},
            :length => {maximum: 4, message: 'Digite um ano válido.'}
  validates :half, :presence => {message: 'O semestre é um valor obrigatório.'},
            :length => {maximum: 1, message: 'Digite um semestre válido (1 ou 2).'}
  validates :tcc, :presence => {message: 'O TCC é um valor obrigatório.'},
            :length => {maximum: 1, message: 'Digite um valor válido para o TCC (1 ou 2)'}
  validate :calendar_is_unique, on: :create

  def delete_items
    item_base_timeline.destroy_all
  end

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
    base_url = APP_CONFIG['root_url']
    params = tcc == "1" ? default_items_hash_tcc1(base_url) : default_items_hash_tcc2(base_url)
    params.each do |param|
      item = ItemBaseTimeline.create param
      if item.link.index("{{id}}") != nil
        item.link = item.link.gsub! "{{id}}", item.id.to_s
        item.save
      end
    end
  end

  def default_items_hash_tcc1(base_url)
    first_month = half == "1" ? 3 : 8
    [
      {
        title: 'Entrega do termo de compromisso de orientação',
        _type: 'document',
        description: 'Nesta etapa o acadêmico deve entregar um termo assinado por ele próprio e pelo seu orientador.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, (first_month), 15)
      },
      {
        title: 'Entrega da proposta',
        _type: 'document',
        description: 'Entregar a proposta para professor de TCC 1, assim como, para o professor orientador para a correção.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, (first_month+1), 15)
      },
      {
        title: 'Defesa da proposta',
        _type: 'presentation',
        description: 'O acadêmico deve realizar uma apresentação de no máximo 15 minutos para defender sua proposta de TCC. Este será avaliado por uma banca composta de 3 professores.',
        base_timeline_id: id,
        link: '#',
      },
      {
        title: 'Entrega da versão final da proposta',
        _type: 'document',
        description: 'O acadêmico deve entregar, em formato pdf, a versão corrigida da sua proposta de TCC para o professor da disciplina de TCC 1.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, (first_month+1), 25)
      },
      {
        title: 'Entrega do projeto',
        _type: 'document',
        description: 'O acadêmico deve entregar projeto de TCC, encadernado, ao professor de TCC 1, para que seja encaminhada para avaliação dos professores que participarão da banca final de TCC 1.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, (first_month+2), 1)
      },
      {
        title: 'Entrega da ficha de autorização de defesa',
        _type: 'document',
        description: 'Acompanhado do projeto, o acadêmico deve entregar a Ficha de Autorização para Realização da Defesa de TCC assinada pelo seu orientador.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, (first_month+2), 1)
      },
      {
        title: 'Entrega da ficha de acompanhamento de atividades',
        _type: 'document',
        description: 'Acompanhado do projeto, o acadêmico deve entregar a Ficha de Acompanhamentos de Atividades de TCC assinada.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, (first_month+2), 1)
      },
      {
        title: 'Defesa do projeto',
        _type: 'presentation',
        description: 'O acadêmico deve realizar uma apresentação de no máximo 20 minutos para defender o desenvolvimento de seu projeto. Esta apresentação assim como o texto escrito, será avaliado por uma banca composta de 3 professores.',
        base_timeline_id: id,
        link: '#',
      },
      {
        title: 'Entrega da versão final do projeto',
        _type: 'document',
        description: 'O acadêmico deve entregar, no formato pdf, a versão corrigida do seu projeto para o professor da disciplina de TCC 1.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, (first_month+2), 1)
      }
    ]
  end

  def default_items_hash_tcc2(base_url)
    # guardar em um arquivo
    [
      {
        title: 'Entrega da monografia de TCC',
        _type: 'document',
        description: 'O acadêmico deve entregar 3 cópias encadernadas da monografia final ao professor responsável pelo TCC, para que seja encaminhada para avaliação dos professores que participarão da banca de TCC 2.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, 11, 1)
      },
      {
        title: 'Entrega da ficha de autorização de defesa',
        _type: 'document',
        description: 'Acompanhado da monografia, o acadêmico deve entregar a Ficha de Encaminhamento de TCC para Banca Avaliadora assinada pelo seu orientador.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, 11, 1)
      },
      {
        title: 'Entrega da ficha de acompanhamento de atividades',
        _type: 'document',
        description: 'Acompanhado do projeto, o acadêmico deve entregar a Ficha de Acompanhamentos de Atividades de TCC assinada.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, 11, 1)
      },
      {
        title: 'Defesa do TCC',
        _type: 'presentation',
        description: 'O acadêmico deve realizar uma apresentação de no máximo 20 minutos para defender o seu trabalho de TCC. Esta apresentação, assim como a monografia, será avaliado por uma banca composta de 3 professores.',
        base_timeline_id: id,
        link: '#',
      },
      {
        title: 'Entrega da monografia corrigida',
        _type: 'document',
        description: 'Após as correções solicitadas pela banca o aluno deve entregar a versão final do TCC para o professor responsável juntamente com a ficha de encaminhamento da versão final do TCC, nas datas divulgadas em cada semestre.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, 11, 1)
      },
      {
        title: 'Depósito do trabalho na biblioteca',
        _type: 'document',
        description: 'Após as correções solicitadas pela banca o aluno deve entregar a versão final do TCC para o professor responsável juntamente com a ficha de encaminhamento da versão final do TCC, nas datas divulgadas em cada semestre.',
        base_timeline_id: id,
        link: 'http://'+base_url+'/academico/item/{{id}}',
        date: Date.new(year, 11, 1)
      }
    ]
  end
end
