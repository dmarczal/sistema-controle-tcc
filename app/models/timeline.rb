class Timeline < ActiveRecord::Base
  has_many :item_timelines
  has_one :bank
  has_many :orientations
  has_many :teachers, through: :teacher_timelines
  has_many :teacher_timelines
  belongs_to :student
  belongs_to :bank
  belongs_to :base_timeline

  validates :base_timeline, :presence => {message: 'Ainda não foi referenciado um calendário para esse TCC.'}
  validates :title, :presence => {message: 'Uma timeline precisa de um título.'}
  validates :teachers, :length => { :minimum => 1, message: 'Selecione pelo menos 1 professor orientador.' }
  validates :student, :presence => {message: 'Uma timeline precisa de um acadêmico.'}

  before_destroy :delete_items

  def delete_items
    item_timelines.destroy_all
  end

  def delete
    ItemTimeline.where(timeline_id: self.id).destroy_all
    super
  end

  def to_s
    self.student.name + ', ' + 'TCC '+self.base_timeline.tcc.to_s+', '+self.base_timeline.half.to_s+'º de '+self.base_timeline.year.to_s
  end

  def serialize
    s = self.attributes
    student = Student.find self.student_id
    s[:student_name] = student.name
    s[:base_timeline] = self.base_timeline
    _items = ItemTimeline.where :timeline_id => self.id
    items = Array.new
    _items.each do |i|
      b_item = i.item_base_timeline
      item = b_item.attributes
      item[:status] = i.status
      items.push item
    end
    s[:items] = items
    s
  end

  def create_items
    self.base_timeline.item_base_timeline.each do |item|
      i = ItemTimeline.new :item_base_timeline => item, :status_item => StatusItem.find_by(name: "Nenhum")
      i.save
      self.item_timelines.push i
    end
    self.save
  end
end
