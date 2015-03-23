class Timeline < ActiveRecord::Base
  has_many :item_timelines
  belongs_to :teacher
  belongs_to :student
  belongs_to :base_timeline

  validates :base_timeline, :presence => {message: 'Ainda não foi referenciado um calendário para esse TCC.'}
  validates :teacher, :presence => {message: 'Uma timeline precisa de um professor orientador.'}
  validates :student, :presence => {message: 'Uma timeline precisa de um acadêmico.'}
  validate :tcc_is_valid

  def tcc_is_valid
    s = self.student
    exist = false
    if s.timeline.length
      s.timeline.each do |t|
        base = t.base_timeline
        if base.tcc == self.base_timeline.tcc
          exist = true
        end
      end
    end
    if exist
      errors.add(:tcc, 'TCC já cadastrado para este aluno.')
    end
  end

  def serialize
    s = self.attributes
    student = Student.find self.student_id
    s[:student_name] = student.name
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

  def createItems
    self.base_timeline.item_base_timeline.each do |item|
      i = ItemTimeline.new :item_base_timeline => item
      i.save
      self.item_timelines.push i
    end
    self.save
  end
end
